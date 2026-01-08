class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.108.3.tar.gz"
  sha256 "98ca98a84c4a48e0c39d3da33f09f53285a2137dccca8e0552133913a4564c8f"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 52
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "369a6d343e403fddf67a9da0ba7f0db61b3476a4a7da5d164b39b84acd46f09e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "c75d78bbd55803eea54b7e7013013b6d86559599919bb2f5c068d4f61efcc7a9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0506cf951a7e313cc572c8042ee3ea710d31132a3f932c3c548aef638a16ee99"
  end

  depends_on "go" => :build

  def install
    with_env(
      TAG_VERSION: version,
    ) do
      system "make", "cli-ci"
    end
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end

  test do
    assert_match "Version", shell_output("#{bin}/viam version")
  end
end
