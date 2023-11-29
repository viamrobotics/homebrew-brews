class Viam < Formula
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.15.0.tar.gz"
  sha256 "5ca465f472dba320e7b57f5e42cc4c373ebfdac5deaa70524569cfb89ab2d5fc"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"
  desc "Viam CLI for managing robots, modules, orgs, etc. on the Viam platform. (See also: viam-server for running a robot)."

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
