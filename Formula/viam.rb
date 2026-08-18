class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v1.4.0.tar.gz"
  sha256 "f6bd350df081f7d0879929d50886e3e853e860d4aefb781984d87052933024a2"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 22
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "34158a6075fe572ace11bbee6e3a73056cc66b5ad10c8e5f8627928c310377a2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7f382a4a4263beccb5ec1990bc8dd182582bd4f1e1f30eb73b7462bb8947dab1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4f2ef2edc2a0c9a5fdd561a26e49990a2403444a44fd9bea504761d6b2fc2142"
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
