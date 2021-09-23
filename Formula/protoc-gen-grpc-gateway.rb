class ProtocGenGrpcGateway < Formula
  desc ""
  homepage ""
  url "https://github.com/grpc-ecosystem/grpc-gateway/archive/refs/tags/v2.6.0.tar.gz"
  sha256 "4a1a50fcb2dafb0134db0be669d3d8d8dd0d6933f88a3e580fee2727ccf5ebc2"
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
