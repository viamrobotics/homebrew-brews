class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v1.14.2.tar.gz"
  sha256 "7ff34e04a15f3f1089d2ae3edd6fa930263a68f049703bbf45e3530795b3e21b"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 35
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "2f256fc6008d52b3f1b461c902b6716410bfb5dde0b21e4df09b050c43b3a2f0"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "161d86d32ce53dfa6191e1779c239d8b69cf24de3ee5d7ed6db50365e9422e0b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "262cb84228123ee4b7d1cff0e5896ddb2b04b9fa66ceb3554a8ed2017b32157c"
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
