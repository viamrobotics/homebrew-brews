class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v1.11.0.tar.gz"
  sha256 "1b9c083ca564f58e4908bc10739088bb1e5a70aaee011673888aa3c9c138afa2"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 28
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "9fdc73fae7a4a3a81fcf03fd2468228c2a42d7ad89c82b55ce068c3fed39ae5d"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "124957a993daffbae2653d9f847193c6976c64fd9def13a43a5164cc18b192c8"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "893b4a4f2a7177febbeed2c24456b979c3367eb7c0eff98481666a0f98077df4"
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
