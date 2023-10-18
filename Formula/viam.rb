class Viam < Formula
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.11.1.tar.gz"
  sha256 "43016368900d40a7592833d00f6477c4aa2f8f7f941273743b488513bccd016f"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"
  desc "Viam CLI for managing robots, modules, orgs, etc. on the Viam platform. (See also: viam-server for running a robot)."

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
