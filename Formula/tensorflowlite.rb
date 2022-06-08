class Tensorflowlite < Formula
  desc "Tensorflow Lite"
  homepage "https://tensorflow.org"
  url "https://github.com/tensorflow/tensorflow/archive/refs/tags/v2.9.1.tar.gz"
  sha256 "6eaf86ead73e23988fe192da1db68f4d3828bcdd0f3a9dc195935e339c95dbdc"
  license "APACHE-2.0"
  head "https://github.com/tensorflow/tensorflow.git", branch: "master"

  depends_on "cmake" => :build

  def install
    inreplace "tensorflow/lite/c/CMakeLists.txt", /common\.c$/, "common.cc"
    mkdir "build"

    system "cmake", "-Bbuild", "-Stensorflow/lite/c"
    system "cmake", "--build", "build", "-j"

    lib.install "build/libtensorflowlite_c.so"

    mkdir_p include/"tensorflow/lite/c"
    include.install "tensorflow/lite/builtin_ops.h" => "tensorflow/lite/builtin_ops.h"
    include.install "tensorflow/lite/c/c_api.h" => "tensorflow/lite/c/c_api.h"
    include.install "tensorflow/lite/c/c_api_experimental.h" => "tensorflow/lite/c/c_api_experimental.h"
    include.install "tensorflow/lite/c/c_api_for_testing.h" => "tensorflow/lite/c/c_api_for_testing.h"
    include.install "tensorflow/lite/c/c_api_types.h" => "tensorflow/lite/c/c_api_types.h"
    include.install "tensorflow/lite/c/common.h" => "tensorflow/lite/c/common.h"
  end

end
