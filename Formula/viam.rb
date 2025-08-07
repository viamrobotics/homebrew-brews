class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.87.1.tar.gz"
  sha256 "882d8a04eb065704b7ca97ac16f3ac73be6331e510e67a22e97ba226099c6e54"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 20
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2b52652689b211e85887d48c3ab24f92369cac901a8ba8c863c4a2aef4043986"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "43e7f3f20341e257b34b03874a704303f486c52e072cf28cc42a622da56d5fdb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "186aec960352a07bcac86e2f83ce280fd34a71ad91534d8650cdfca56fd1b261"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
