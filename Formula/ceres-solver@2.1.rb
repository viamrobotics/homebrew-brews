class CeresSolverAT21 < Formula
  desc "C++ library for large-scale optimization"
  homepage "http://ceres-solver.org/"
  url "http://ceres-solver.org/ceres-solver-2.1.0.tar.gz"
  sha256 "f7d74eecde0aed75bfc51ec48c91d01fe16a6bf16bce1987a7073286701e2fc6"
  license "BSD-3-Clause"
  revision 3
  head "https://ceres-solver.googlesource.com/ceres-solver.git", branch: "master"

  livecheck do
    skip "intentionally held back"
  end

  depends_on "cmake" => [:build, :test]
  depends_on "eigen"
  depends_on "gflags"
  depends_on "glog"
  depends_on "metis"
  depends_on "openblas"
  depends_on "suite-sparse@7.1"
  depends_on "tbb"

  fails_with gcc: "5" # C++17

  # Fix version detection for suite-sparse >= 6.0. Remove in next release.
  patch do
    url "https://github.com/ceres-solver/ceres-solver/commit/352b320ab1b5438a0838aea09cbbf07fa4ff5d71.patch?full_index=1"
    sha256 "0289adbea4cb66ccff57eeb844dd6d6736c37649b6ff329fed73cf0e9461fb53"
  end

  def install
    system "cmake", "-S", ".", "-B", "homebrew-build",
                    "-DBUILD_SHARED_LIBS=ON",
                    "-DBUILD_EXAMPLES=OFF",
                    "-DLIB_SUFFIX=''",
                    "-DCXSPARSE=OFF",
                    *std_cmake_args
    system "cmake", "--build", "homebrew-build"
    system "cmake", "--install", "homebrew-build"
    pkgshare.install "examples", "data"
  end

  test do
    cp pkgshare/"examples/helloworld.cc", testpath
    (testpath/"CMakeLists.txt").write <<~EOS
      cmake_minimum_required(VERSION 3.5)
      project(helloworld)
      find_package(Ceres REQUIRED COMPONENTS SuiteSparse)
      add_executable(helloworld helloworld.cc)
      target_link_libraries(helloworld Ceres::ceres)
    EOS

    system "cmake", "."
    system "make"
    assert_match "CONVERGENCE", shell_output("./helloworld")
  end
end
