class Viam < Formula
  desc "CLI for managing robots, orgs, etc. (See viam-server for running a robot)"
  homepage "https://docs.viam.com/cli/"
  url "https://github.com/viamrobotics/rdk/archive/refs/tags/v0.101.0.tar.gz"
  sha256 "4686fe9c2849fd3cce6c8289b3cce4c862877390ea95dceb93909f40eca3ae55"
  license "AGPL-3.0"
  head "https://github.com/viamrobotics/rdk.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/viamrobotics/brews"
    rebuild 39
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d01753d21c4493d17f6125ab6e5c178febd66e8b880f1f386e3e9b9dc426c89e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7e27f153ee3b96c3afdb9ea4c42461948b423c2d63ed9f34a423829de4803622"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "41cc31913a1c72a5282af060564128de712f815dc41831f4cfe4b680d3cc49d3"
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
