#include <cstdio>
#include <cstdlib>
#include <vector>
#include <algorithm>
#include "elf.h"
using namespace std;

typedef unsigned char Byte;
typedef unsigned int Addr;

Addr lo_addr = -1;
Addr hi_addr = 0;
vector<Elf64_Phdr*> program_header_ptrs;

void elf_file_reader(FILE* in_file_ptr, Byte* elf_file_buffer_ptr, size_t elf_size)
{
    if(fread(elf_file_buffer_ptr, 1, elf_size, in_file_ptr)!=elf_size)
    {
        printf("[error-dumper] file reading error!\n");
        exit(-3);
    }
}

int cmp(Elf64_Phdr* a_ptr, Elf64_Phdr* b_ptr)
{
    return a_ptr->p_vaddr < b_ptr->p_vaddr;
}

void program_headers_reader(Byte* elf_file_buffer_ptr)
{
    Elf64_Ehdr* elf_header_ptr = (Elf64_Ehdr*)elf_file_buffer_ptr;
    for(int program_headers_index = 0; program_headers_index < elf_header_ptr->e_phnum; program_headers_index++)
    {
        Elf64_Phdr *program_header_ptr = (Elf64_Phdr *)(elf_file_buffer_ptr + elf_header_ptr->e_phoff + program_headers_index * elf_header_ptr->e_phentsize);
        if(program_header_ptr->p_type == PT_LOAD) //Loadable segment
        {
            program_header_ptrs.push_back(program_header_ptr);
        }
    }

    sort(program_header_ptrs.begin(), program_header_ptrs.end(), cmp);
}

void program_dumper(const Byte* elf_file_buffer_ptr, const char* dump_filename_ptr)
{
    remove(dump_filename_ptr);
    FILE* dump_file_ptr = fopen(dump_filename_ptr,"wb+");
    if(dump_file_ptr == NULL)
    {
        printf("[error-dumper] error during the openning of the dump file!\n");
        exit(-4);
    }

    for(vector<Elf64_Phdr*>::iterator it = program_header_ptrs.begin(); it != program_header_ptrs.end(); it++)
    {
        printf("[info-dumper] p.vaddr = %016llx, p.memsize = %016llu, p.filesize = %016llu\n", (*it)->p_vaddr, (*it)->p_memsz, (*it)->p_filesz);

        if((*it)->p_vaddr + (*it)->p_memsz > hi_addr)	hi_addr = (*it)->p_vaddr;
        if((*it)->p_vaddr < lo_addr)					lo_addr = (*it)->p_vaddr;

        if(it != program_header_ptrs.begin())
        {
            vector<Elf64_Phdr*>::iterator it_before = it-1;
            size_t blank_size = (*it)->p_vaddr - ((*it_before)->p_vaddr + (*it_before)->p_memsz);
            for(size_t index = 0; index < blank_size; index++)
            {
                fprintf(dump_file_ptr, "%02x\n", 0);
            }
        }

        const Byte* payload_ptr = elf_file_buffer_ptr + (*it)->p_offset;
        for(size_t index = 0; index < (*it)->p_memsz; index++, payload_ptr++)
        {
            fprintf(dump_file_ptr,"%02x\n", *payload_ptr);
        }
    }

    fclose(dump_file_ptr);
}

void addr_dumper(const Byte* elf_file_buffer_ptr, const char* dump_filename_ptr, const char* dump_addr_filename_ptr)
{
    Elf64_Ehdr* elf_header_ptr = (Elf64_Ehdr*)elf_file_buffer_ptr;
    printf("[info-dumper] Entry point = 0x%016llx, Total_Mem_Size = %u Bytes\n", elf_header_ptr->e_entry, hi_addr - lo_addr);

    remove(dump_addr_filename_ptr);
    FILE* dump_addr_file_ptr = fopen(dump_addr_filename_ptr,"wb+");
    if(dump_addr_file_ptr == NULL)
    {
        printf("[error-dumper] error during the openning of the dump file!\n");
        exit(-4);
    }
    fprintf(dump_addr_file_ptr, "`define PC_RESET       64'h%016llx\n", elf_header_ptr->e_entry);
    fprintf(dump_addr_file_ptr, "`define MEM_OFFSET     %d\n", lo_addr);
    fprintf(dump_addr_file_ptr, "`define MEM_SIZE       %d\n", hi_addr - lo_addr + 1);
    fprintf(dump_addr_file_ptr, "`define MEM_FILE_PATH  \"%s\"\n", dump_filename_ptr);
    fprintf(dump_addr_file_ptr, "`define SIM");

    fclose(dump_addr_file_ptr);
}

int main(int argc, char **argv)
{
    printf("\n");

    Byte* elf_file_buffer_ptr;
    size_t elf_size;

    if(argc < 2)
    {
        printf("[error-dumper] needs an elf input!\n");
        exit(-1);
    }
    else if(argc < 3)
    {
        printf("[error-dumper] needs to assign a dump filename!\n");
        exit(-1);
    }
    else if(argc < 4)
    {
        printf("[error-dumper] needs to assign a dump_addr filename!\n");
        exit(-1);
    }
    else
    {
        FILE* in_file_ptr = fopen(argv[1],"rb");
        if(in_file_ptr == NULL)
        {
            printf("[error-dumper] file open error!\n");
            exit(-2);
        }
        else
        {
            fseek(in_file_ptr,0,SEEK_END);
            elf_size = ftell(in_file_ptr);
            printf("[info-dumper] Elf to be loaded is %s, size = %ld Bytes\n", argv[1], elf_size);
            rewind(in_file_ptr);

            elf_file_buffer_ptr = (Byte*) malloc(elf_size);

            elf_file_reader(in_file_ptr, elf_file_buffer_ptr, elf_size);
            fclose(in_file_ptr);

            program_headers_reader(elf_file_buffer_ptr);
            program_dumper(elf_file_buffer_ptr, argv[2]);
            addr_dumper(elf_file_buffer_ptr, argv[2], argv[3]);

            free(elf_file_buffer_ptr);
        }

    }

    printf("\n");
    return 0;
}
