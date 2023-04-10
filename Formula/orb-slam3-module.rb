class OrbSlam3Module < Formula
  desc "Viam ORB_SLAM3 modular service"
  homepage "https://www.viam.com/"
  url "https://github.com/viamrobotics/viam-orb-slam3.git",
    tag:      "v0.3.1",
    revision: "3726e0f9e8f05402406eeb81d52d39dcbf432b53"
  license "Apache-2.0"
  head "https://github.com/viamrobotics/viam-orb-slam3.git", branch: "main"

  depends_on "cmake" => :build
  depends_on "go" => :build
  depends_on "pkg-config" => :build
  depends_on "boost"
  depends_on "eigen"
  depends_on "glew"
  depends_on "grpc"
  depends_on "opencv@4"
  depends_on "openssl"
  depends_on "pangolin"

  def install
    system "make", "buf"
    system "make", "build"
    if OS.mac?
      system "install_name_tool", "-change",
buildpath.to_s.delete_prefix("/private") + "/viam-orb-slam3/ORB_SLAM3/Thirdparty/DBoW2/lib/libDBoW2.dylib", "#{lib}/libDBoW2.dylib", "viam-orb-slam3/ORB_SLAM3/lib/libORB_SLAM3.dylib"
      system "install_name_tool", "-change",
buildpath.to_s.delete_prefix("/private") + "/viam-orb-slam3/ORB_SLAM3/Thirdparty/g2o/lib/libg2o.dylib", "#{lib}/libg2o.dylib", "viam-orb-slam3/ORB_SLAM3/lib/libORB_SLAM3.dylib"
      system "install_name_tool", "-change",
buildpath.to_s.delete_prefix("/private") + "/viam-orb-slam3/ORB_SLAM3/Thirdparty/DBoW2/lib/libDBoW2.dylib", "#{lib}/libDBoW2.dylib", "viam-orb-slam3/bin/orb_grpc_server"
      system "install_name_tool", "-change",
buildpath.to_s.delete_prefix("/private") + "/viam-orb-slam3/ORB_SLAM3/Thirdparty/g2o/lib/libg2o.dylib", "#{lib}/libg2o.dylib", "viam-orb-slam3/bin/orb_grpc_server"
      system "install_name_tool", "-change",
buildpath.to_s.delete_prefix("/private") + "/viam-orb-slam3/ORB_SLAM3/lib/libORB_SLAM3.dylib", "#{lib}/libORB_SLAM3.dylib", "viam-orb-slam3/bin/orb_grpc_server"
    end
    bin.install "bin/orb-slam3-module"
    bin.install "viam-orb-slam3/bin/orb_grpc_server"
    lib.install Dir["viam-orb-slam3/ORB_SLAM3/lib/*"]
    lib.install Dir["viam-orb-slam3/ORB_SLAM3/Thirdparty/DBoW2/lib/*"]
    lib.install Dir["viam-orb-slam3/ORB_SLAM3/Thirdparty/g2o/lib/*"]
    (share/"orbslam/Vocabulary").mkpath
    share.install "viam-orb-slam3/ORB_SLAM3/Vocabulary/ORBvoc.txt" => "orbslam/Vocabulary/ORBvoc.txt"
  end
end
