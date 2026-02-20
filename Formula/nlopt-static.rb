class NloptStatic < Formula
  # WARNING: if you update this, you must manually create the bottle for it; otherwise RDK/CLI bottling will fail.
  # The quickest way to do this is to edit test-bottle.yml in a branch so it only bottles + uploads nlopt, then run it.
  desc "Free/open-source library for nonlinear optimization"
  homepage "https://nlopt.readthedocs.io/"
  url "https://github.com/stevengj/nlopt/archive/v2.10.0.tar.gz"
  sha256 "506f83a9e778ad4f204446e99509cb2bdf5539de8beccc260a014bd560237be1"
  license "LGPL-2.1"
  head "https://github.com/stevengj/nlopt.git", branch: "master"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 1
    sha256 cellar: :any,                 arm64_sequoia: "a7a2eee5173922106e514f9ab3e3e7256be80871c6b0df9aacb9b342667ce274"
    sha256 cellar: :any,                 arm64_sonoma:  "4737cce2fcf7fdac274b78f989af9be7fd23ee335808cf3884821a02ab85649a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d937c1500ea8fc98a41ce5b7e6d686763a4519036af6218b5326c40668be46a4"
  end

  depends_on "cmake" => [:build, :test]
  conflicts_with "nlopt", because: "nlopt-static provides dynamic and static libraries"
  option "without-shared", "Only include static libraries and no dynamic libraries"

  def install
    args = *std_cmake_args + %w[
      -DNLOPT_GUILE=OFF
      -DNLOPT_MATLAB=OFF
      -DNLOPT_OCTAVE=OFF
      -DNLOPT_PYTHON=OFF
      -DNLOPT_SWIG=OFF
      -DNLOPT_TESTS=OFF
    ]

    if (!build.without? "shared")
      mkdir "build" do
        system "cmake", *args, ".."
        system "make"
        system "make", "install"
      end
    end

    args = *args + %w[-DBUILD_SHARED_LIBS=OFF]
    mkdir "build_static" do
      system "cmake", *args, ".."
      system "make"
      system "make", "install"
    end

    pkgshare.install "test/box.c"
  end

  test do
    (testpath/"CMakeLists.txt").write <<~EOS
      cmake_minimum_required(VERSION 3.0)
      project(box C)
      find_package(NLopt REQUIRED)
      add_executable(box "#{pkgshare}/box.c")
      target_link_libraries(box NLopt::nlopt)
    EOS
    system "cmake", "."
    system "make"
    assert_match "found", shell_output("./box")
  end
end
