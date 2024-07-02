class ViamCppSdk < Formula
  desc "Viam C++ SDK"
  homepage "https://www.viam.com/"
  url "https://github.com/viamrobotics/viam-cpp-sdk.git",
    tag:      "releases/v0.0.8",
    revision: "a6b4ac178d367cd273ddcf4c996fc653bc3cb156"
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
