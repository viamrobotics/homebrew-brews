class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.51.2.tar.gz"
  sha256 "4b9976fb1b52daf80b774942896decb9a5916ebbeb52b8b6e7925f7bb776ff11"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 7
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7893b4e959c9a016fdbbe0f5a04da1fdf638756a25b75c2b0d3607b4919fdbb0"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c4497af324b1364efec34d5c7de00f6d112c49d8c4a34b80f8c25905facd872c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "aba1f36f486f1c2ad1445cf5f9fb5064cb32b627a21ca703cae739b9a7ac92e5"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
