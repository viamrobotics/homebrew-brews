class CartographerModule < Formula
  desc "Viam cartographer modular service"
  homepage "https://www.viam.com/"
  url "https://github.com/viamrobotics/viam-cartographer.git",
    tag:      "v0.3.2",
    revision: "e543ccc47d7ed10094a26d0a4ea5f88dbfeb1e1c"
  license "Apache-2.0"
  head "https://github.com/viamrobotics/viam-cartographer.git", branch: "main"

  conflicts_with "carto-grpc-server", because: "carto-grpc-server also installs carto_grpc_server"

  depends_on "cmake" => :build
  depends_on "go" => :build
  depends_on "ninja" => :build
  depends_on "protobuf"
  depends_on "grpc"
  depends_on "pcl"

  def install
    system "make", "buf"
    system "make", "build"

    bin.install "bin/cartographer-module"
    bin.install "viam-cartographer/build/carto_grpc_server"
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
