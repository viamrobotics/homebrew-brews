class OrbGrpcServer < Formula
  desc "A Viam slam GRPC server for ORB_SLAM3"
  homepage "https://www.viam.com/"
  url "https://github.com/viamrobotics/slam/archive/refs/tags/v0.1.4.tar.gz"
  sha256 "26af8f02105cb2bfe3c8f3e6ba9b73100ea8d77098d58a535b1e2d4c56bb907c"
  license "Apache-2.0"
  head "https://github.com/tessavitabile/slam.git", branch: "DATA-605"

  depends_on "pkg-config" => :build
  depends_on "go" => :build
  depends_on "cmake" => :build
  depends_on "grpc"
  depends_on "glew"
  depends_on "opencv@4"
  depends_on "eigen"
  depends_on "boost"
  depends_on "openssl"
  depends_on "pangolin"

  def install
    chdir "slam-libraries" do
      system "make", "buf"
      system "make", "buildorb"
      bin.install "viam-orb-slam3/bin/orb_grpc_server"
      lib.install Dir["viam-orb-slam3/ORB_SLAM3/lib/*"]
      lib.install Dir["viam-orb-slam3/ORB_SLAM3/Thirdparty/DBoW2/lib/*"]
      lib.install Dir["viam-orb-slam3/ORB_SLAM3/Thirdparty/g2o/lib/*"]
      (share/"orbslam/Vocabulary").mkpath
      share.install "viam-orb-slam3/ORB_SLAM3/Vocabulary/ORBvoc.txt" => "orbslam/Vocabulary/ORBvoc.txt"
    end
  end
end
