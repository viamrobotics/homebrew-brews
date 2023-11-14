class CartographerModule < Formula
  desc "Viam cartographer modular service"
  homepage "https://www.viam.com/"
  url "https://github.com/viamrobotics/viam-cartographer.git",
    tag:      "v0.3.39",
    revision: "3905758c2a20a80a09dd19bde97441f1fb92448a"
  license "Apache-2.0"
  head "https://github.com/viamrobotics/viam-cartographer.git", branch: "main"

  depends_on "cmake" => :build
  depends_on "go" => :build
  depends_on "ninja" => :build
  depends_on "pkg-config" => :build
  depends_on "protobuf@21"
  depends_on "grpc"
  depends_on "googletest"
  depends_on "ceres-solver"
  depends_on "pcl"
  depends_on "lua@5.3"
  depends_on "cairo"
  depends_on "nlopt-static"

  def install
    system "make", "buf"
    system "make", "build"

    if OS.linux?
      if Hardware::CPU.intel?
        bin.install "bin/Linux-x86_64/cartographer-module" => "cartographer-module"
      elsif Hardware::CPU.arm?
        bin.install "bin/Linux-aarch64/cartographer-module" => "cartographer-module"
      end
    elsif OS.mac?
      if Hardware::CPU.intel?
        bin.install "bin/Darwin-x86_64/cartographer-module" => "cartographer-module"
      elsif Hardware::CPU.arm?
        bin.install "bin/Darwin-arm64/cartographer-module" => "cartographer-module"
      end
    end
    
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
