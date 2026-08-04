class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v1.2.0.tar.gz"
  sha256 "36db9e2b46c5d1cdb96e3bfeebe567dbebc8afd312c24d8a6fcfac0d734d7a57"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 20
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2492d238bb0c84c0509f07a89053d746d9fd00689a307dcf0852b6c71574ffe8"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "ab452dc94d62cd8d603f52915f7eeab5be47a932d6ebe601c2cf74de08e76fd5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e6d6b38d070874640fec48c0df47e8cedec703d65d3ece08b692ecba9d77e6c3"
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
