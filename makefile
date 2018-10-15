.PHONY: chisel

chisel:
	$(sbt "runMain cacheDriver")
	$(cp ./true_unified_cache.v ./pumpkin/rtl/unified_cache/true_unified_cache.v )
	