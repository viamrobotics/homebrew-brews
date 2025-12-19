class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.106.1.tar.gz"
  sha256 "9c7bdba4955ca0c7f1bb31e3ff77a99b47b1606154b9e4a197a7eed84e67a7f6"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 46
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "bca619c74621d165baed1e5a177b4769ff1ad2b8a44fc0bd1f2ba5cb15d4f07d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "24f1daa648b33bf6af074a2dfbb271b843d56cf78b31fd2a2ec19870494956d0"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "754b41d5d593bf13245b00bfe9cef0d79d377667f920a04f0cba93579667a989"
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
