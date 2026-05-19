class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.127.1.tar.gz"
  sha256 "f8e78bca2307a92f71afa3a4f188de04f9fbf011705a5791e748add19ed11e85"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 8
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "94de0180b1962b916df23b635c1911c003f8720d08f53a430d3b01f0815a4696"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2689596670acb345aeb8a565b578662410087c4ce457910860093129c76c557d"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "46d96b7066a7ba68e70ac4e184a95738a9591c6c7308e24efc61b51da0aa3d65"
  end

  depends_on "go" => :build

  def install
    with_env(
      TAG_VERSION: version,
    ) do
      system "make", "cli-ci"
    end
    bin.install Dir["bin/*/viam-cli"][0] => "viam"
    generate_completions_from_executable(bin/"viam", "completion")
  end

  test do
    assert_match "Version", shell_output("#{bin}/viam version")
  end
end
