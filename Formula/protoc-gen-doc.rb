class ProtocGenDoc < Formula
  desc "Documentation generator plugin for Google Protocol Buffers"
  homepage ""
  url "https://github.com/pseudomuto/protoc-gen-doc/archive/refs/tags/v1.5.0.tar.gz"
  sha256 "8e77b5645d40257b6e674b4da3767d6cea77d150e276f4a9ffbab3a15156ebba"
  license "MIT"

  depends_on "go" => :build

  def install
  	cd "cmd/protoc-gen-doc"
    system "go", "build", *std_go_args
  end

  test do

  end
end
