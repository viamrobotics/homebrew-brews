class ViamRsCameraServer < Formula
  desc "A Viam camera GRPC server for the Intel RealSense"
  homepage "https://www.viam.com/"
  url "https://github.com/viamrobotics/camera-servers/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "928cff021883e0e3740bd8732feb072315afe79bf53d928b8452d5a83ee3a67d"
  license "Apache-2.0"
  head "https://github.com/viamrobotics/camera-servers.git", branch: "main"

  depends_on "pkg-config" => :build
  depends_on "go" => :build
  depends_on "openssl"
  depends_on "grpc"
  depends_on "protobuf"
  depends_on "libhttpserver"
  depends_on "opencv"
  depends_on "librealsense"

  def install
    system "mkdir", "grpc/bin"
    system "make", "buf"
    system "make", "intelrealgrpcserver"
    bin.install "intelrealgrpcserver"
  end
end
