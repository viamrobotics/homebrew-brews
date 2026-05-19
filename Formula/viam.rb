class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.127.0.tar.gz"
  sha256 "9afede1e4e8440151651fca44702aea399cc797c0ab1c5d726a1c85956e29a19"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 7
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f730a1e06a16f4172da465b534a7941d11aa9a2ad9510cb74ed9934d8f12c940"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5e5930ba7810a50f96790483b424a4a0fc4f58713b4cbc4c858c578ae464dc53"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0cbc9d684f182a4b38681e5331af30f44deeadc158e9215a378f7e01a42f04bc"
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
