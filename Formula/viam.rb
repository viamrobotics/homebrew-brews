class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.108.0.tar.gz"
  sha256 "a000f1dd09a3f3d83749e24ed4ba4452d73f38046f37b32be58033c54e9665b5"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 50
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2b70a6fe6185f4d32415fa786087f282f8b06c9bb1804790bb024887a285c96d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "787e7b0b8f50200be181720b689e33e6ce2c9bade36ddab144a696f81fda7398"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4b154e072f447e5e11073e0d4a017870e86eb929d0c1a7233819cf94018bf8e3"
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
