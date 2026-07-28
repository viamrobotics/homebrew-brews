class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "c05294f13745d6df134f38660332aab49322c7e56b5fdd08cdbce8c681e657a6"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 18
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "69aa61e47834a7eede3e2150f27c5fd0de077c3dc3f7dd99f3dd08aea444d444"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e4afb026b2498b8b2f99dec2f42f90993a7cbe196147b3aee9e9772035587d3a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "8eb00db7f8175c7884363f6530cb93c2874cf3ba68e30206b858564c7455892c"
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
