class ViamCppSdk < Formula
  desc "Viam C++ SDK"
  homepage "https://www.viam.com/"
  url "https://github.com/viamrobotics/viam-cpp-sdk.git",
    tag:      "releases/v0.18.0",
    revision: "3829c8f42778c1f0e2f531fe790a0d6c53f3111e"
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
    system "cmake", "-S", ".", "-B", "build", "-DFETCHCONTENT_FULLY_DISCONNECTED=ON", "-DHOMEBREW_ALLOW_FETCHCONTENT=ON", *std_cmake_args
    system "cmake", "--build", "build"
    system "cmake", "--install", "build"
  end
end
