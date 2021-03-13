protoc ./proto/*.proto \
	--swift_out=./grpc-swift-sample/grpc \
	--grpc-swift_out=./grpc-swift-sample/grpc \
	--swift_opt=Visibility=Public \
	--grpc-swift_opt=Visibility=Public
