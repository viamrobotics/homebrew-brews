class ProtocGenGrpcGateway < Formula
  desc ""
  homepage ""
  url "https://github.com/grpc-ecosystem/grpc-gateway/archive/refs/tags/v2.7.2.tar.gz"
  sha256 "6bbbaef3cef058cec015dbfca6cf2cde67b8337f8e6edbbb887a462781edae45"
  license "BSD-3-Clause"

  depends_on "go" => :build

  def install
    cd "protoc-gen-grpc-gateway" do
      system "go", "build", *std_go_args
    end
  end

  test do

  end
end
