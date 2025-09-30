class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.95.0.tar.gz"
  sha256 "777a9d7461ef105efe77f4ae1eb4f0eb7166646b80374109318a8fca28d7bd8b"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 30
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "152e658002a6056a22afefcb9cdd46567fca54c90c2e034081bbf9774e7c96c9"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "711c2749bc67bc70ce375437e35e1cfd8dd6b3a2702d5e703ae6dbd1f950b831"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2b8765c2769fe7f013533de2e3d05e1e0b2a43ab7acf1d8f3850df96d3c72716"
  end

  depends_on "go" => :build

  def install
    ENV["TAG_VERSION"] = version
    system("make", "cli-ci")
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
  end
end
