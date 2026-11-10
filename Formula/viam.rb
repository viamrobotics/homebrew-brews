class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v1.16.0.tar.gz"
  sha256 "56fa010859cb7f5a753a3ef74c47dcb4f84b4c077b36398755c366bf4dfaceaf"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 40
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "8ba226a280272fa6f70414b53c802655eff5f5085563516bde56f700dba71e2d"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "307abb13e68e9d16fe79558083f8c2da644e9e389e428950d88c6d619f748a8c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "25cda82d56525b0c7da1ef01abdadd343e809c0eacbae02f1389d28a46fe2734"
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
