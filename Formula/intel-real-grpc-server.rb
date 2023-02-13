class IntelRealGrpcServer < Formula
  desc "Viam Camera gRPC server for Intel RealSense devices"
  homepage "https://www.viam.com/"
  url "https://github.com/viamrobotics/camera-servers/archive/refs/tags/v0.2.1.zip"
  sha256 "e0374b26e0b6a1aecda613287ce07fea28dde63319ad4452bc50f6143ccdae48"
  license "Apache-2.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  depends_on "go" => :build
  depends_on "pkg-config" => :build
  depends_on "grpc"
  depends_on "librealsense"
  depends_on "jpeg-turbo"
  depends_on "openssl"

  def install
    system "make", "intelrealgrpcserver-release-opt"
    bin.install "intelrealgrpcserver"
  end
end
