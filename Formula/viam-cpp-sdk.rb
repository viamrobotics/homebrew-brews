class ViamCppSdk < Formula
  desc "Viam C++ SDK"
  homepage "https://www.viam.com/"
  url "https://github.com/viamrobotics/viam-cpp-sdk.git",
    tag:      "releases/v0.14.0",
    revision: "ade116ca7ce9144631192e03205b2a924ee55a81"
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
