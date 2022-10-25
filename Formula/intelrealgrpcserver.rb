class IntelRealGRPCServer < Formula
  desc "A Viam camera GRPC server for the Intel RealSense"
  homepage "https://www.viam.com/"
  url "https://github.com/viamrobotics/camera-servers/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "4e872fb4ea1710c39c5919a4ed0f6e94d319853cd1ae546abf7eeebc9e87167e"
  license "Apache-2.0"
  head "https://github.com/viamrobotics/camera-servers.git", branch: "main"

  depends_on "pkg-config" => :build
  depends_on "go" => :build
  depends_on "grpc"
  depends_on "protobuf"
  depends_on "libhttpserver"
  depends_on "opencv"
  depends_on "librealsense"

  def install
    system "make", "buf"
    system "make", "intelrealgrpcserver"
    bin.install "intelrealgrpcserver"
  end
end
