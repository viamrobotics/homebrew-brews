class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.119.2.tar.gz"
  sha256 "ca8f94f6c37b5d660e14ac9f0f5b0c572754e972a1d38f8033bddc5a3cafd4e1"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 64
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "05aac39be7f84c3b38f3907417509e322245bb274549f8f711b1e0621c46a59b"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a904f0caf790516b9ca89a6f426737fe90346ca9751509be182f818d57019bda"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0524748fe2fa7ce5893269d6b1cfa5ce504795c31311156458a141382dfa6667"
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
