class Pangolin < Formula
  desc "Library for managing OpenGL display / interaction and abstracting video input"
  homepage "https://github.com/stevenlovegrove/Pangolin"
  url "https://github.com/stevenlovegrove/Pangolin/archive/refs/tags/v0.8.tar.gz"
  sha256 "a680d1b52cd432f93f3359cb8f2179b25acf384d29dbaa2530b2eb3dfe5a81c6"
  license "MIT"
  revision 1
  depends_on "catch2" => :build
  depends_on "cmake" => :build
  depends_on "eigen"
  depends_on "ffmpeg"
  depends_on "glew"
  depends_on "libjpeg"
  depends_on "libpng"
  depends_on "libtiff"
  depends_on "libxkbcommon"
  depends_on "lz4"
  depends_on "openexr"
  depends_on "zstd"
  def install
    system "sed", "-i.bak", "/FF_API_XVMC/,+3d",
            "components/pango_video/include/pangolin/video/drivers/ffmpeg_common.h"
    system "cmake", "-S", ".", "-B", "build", *std_cmake_args
    system "cmake", "--build", "build"
    if OS.mac?
      system "install_name_tool", "-add_rpath", lib, "build/libpango_core.dylib"
      system "install_name_tool", "-add_rpath", lib, "build/libpango_display.dylib"
      system "install_name_tool", "-add_rpath", lib, "build/libpango_geometry.dylib"
      system "install_name_tool", "-add_rpath", lib, "build/libpango_glgeometry.dylib"
      system "install_name_tool", "-add_rpath", lib, "build/libpango_image.dylib"
      system "install_name_tool", "-add_rpath", lib, "build/libpango_opengl.dylib"
      system "install_name_tool", "-add_rpath", lib, "build/libpango_packetstream.dylib"
      system "install_name_tool", "-add_rpath", lib, "build/libpango_plot.dylib"
      system "install_name_tool", "-add_rpath", lib, "build/libpango_python.dylib"
      system "install_name_tool", "-add_rpath", lib, "build/libpango_scene.dylib"
      system "install_name_tool", "-add_rpath", lib, "build/libpango_tools.dylib"
      system "install_name_tool", "-add_rpath", lib, "build/libpango_vars.dylib"
      system "install_name_tool", "-add_rpath", lib, "build/libpango_video.dylib"
      system "install_name_tool", "-add_rpath", lib, "build/libpango_windowing.dylib"
      system "install_name_tool", "-add_rpath", lib, "build/libtinyobj.dylib"
    end
    system "cmake", "--install", "build"
  end

  test do
    system "true"
  end
end
