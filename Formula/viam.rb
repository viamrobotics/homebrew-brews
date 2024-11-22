class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.51.2.tar.gz"
  sha256 "4b9976fb1b52daf80b774942896decb9a5916ebbeb52b8b6e7925f7bb776ff11"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 8
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4d3adfbee15a8f2e7bd892fa69ce5a68d01495687fa3a5d367b74cf6ad03f990"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "699f771c69548f63ff0297fdcef95ecafafe90887df792c220d92116a62df742"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "97887fda9405f4e94cade3daf256b5f78f40faf366c96463a6e95a47a5fce59b"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
