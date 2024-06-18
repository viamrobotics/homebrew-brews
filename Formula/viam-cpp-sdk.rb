class ViamCppSdk < Formula
  desc "Viam C++ SDK"
  homepage "https://www.viam.com/"
  url "https://github.com/viamrobotics/viam-cpp-sdk.git",
    tag:      "releases/v0.0.7",
    revision: "fd2d093037a91d4bb7f5fc795899cd0792405b5a"
  license "Apache-2.0"
  head "https://github.com/viamrobotics/viam-cpp-sdk.git", branch: "main"

  depends_on "cmake" => :build
  depends_on "gcc" => :build
  depends_on "abseil"
  depends_on "boost"
  depends_on "grpc"
  depends_on "protobuf"
  depends_on "xtensor"
  depends_on "pkg-config"
  depends_on "ninja"
  depends_on "buf"

  def install
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end
end
