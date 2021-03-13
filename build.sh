protoc ./proto_files/*.proto \
	--swift_out=./HelloGRPC/Sources/HelloGRPC \
	--grpc-swift_out=./HelloGRPC/Sources/HelloGRPC \
	--swift_opt=Visibility=Public \
	--grpc-swift_opt=Visibility=Public

cd HelloGRPC
swift build	
