class CartoGrpcServer < Formula
  desc "Viam slam GRPC server for Cartographer"
  homepage "https://www.viam.com/"
  url "https://github.com/viamrobotics/viam-cartographer.git",
    tag:      "v0.3.0",
    revision: "4167059c0606cea7481122292ae5f16eeefca176"
  license "Apache-2.0"
  head "https://github.com/viamrobotics/viam-cartographer.git", branch: "main"

  conflicts_with "cartographer-module", because: "cartographer-module does also install carto_grpc_server"

  depends_on "cmake" => :build
  depends_on "go" => :build
  depends_on "ninja" => :build
  depends_on "abseil"
  depends_on "boost"
  depends_on "cairo"
  depends_on "ceres-solver"
  depends_on "eigen"
  depends_on "gflags"
  depends_on "glog"
  depends_on "googletest"
  depends_on "grpc"
  depends_on "lua@5.3"
  depends_on "openssl"
  depends_on "pcl"
  depends_on "protobuf"
  depends_on "sphinx-doc"
  depends_on "suite-sparse"

  def install
    system "make", "buf"
    system "make", "build"

    bin.install "viam-cartographer/build/carto_grpc_server"
    lib.install "viam-cartographer/cartographer/build/libcartographer.a"
    lib.install "viam-cartographer/build/libviam-cartographer.a"
    (share/"cartographer/lua_files").mkpath
    share.install "viam-cartographer/lua_files/locating_in_map.lua" => "cartographer/lua_files/"
    share.install "viam-cartographer/lua_files/mapping_new_map.lua" => "cartographer/lua_files/"
    share.install "viam-cartographer/lua_files/updating_a_map.lua" => "cartographer/lua_files/"
    share.install "viam-cartographer/cartographer/configuration_files/map_builder.lua" => "cartographer/lua_files/"
    share.install "viam-cartographer/cartographer/configuration_files/pose_graph.lua" => "cartographer/lua_files/"
    share.install "viam-cartographer/cartographer/configuration_files/trajectory_builder_2d.lua" => "cartographer/lua_files/"
    share.install "viam-cartographer/cartographer/configuration_files/map_builder_server.lua" => "cartographer/lua_files/"
    share.install "viam-cartographer/cartographer/configuration_files/trajectory_builder.lua" => "cartographer/lua_files/"
    share.install "viam-cartographer/cartographer/configuration_files/trajectory_builder_3d.lua" => "cartographer/lua_files/"
  end
end
