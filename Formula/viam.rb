class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.122.0.tar.gz"
  sha256 "1cdcc5a9468c4ed60e03168e8f29558a59d4071d24b5ae120119cd2bb01b6fb9"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9e47f95408e6b03e6f46d76f1eab9a2de8297f0fec9f6360057c6a7d92739db4"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "96422e987cc5cd03b58e6e4d2574970a77b0ecdaf8c4e4bab65d81dd6634c36b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "256123f223be2155ee19b9884d9b1e7cb664ffaf48751293ae1ab2c62224ce05"
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
