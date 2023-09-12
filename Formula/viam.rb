class Viam < Formula
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.8.0.tar.gz"
  sha256 "ec8f0f5a4dda80de5e36e3241a219c0d7e98225754ae0c994dbcd2e4b2d32dd5"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"
  desc "Viam CLI for managing robots, modules, orgs, etc. on the Viam platform. (See also: viam-server for running a robot)."

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
