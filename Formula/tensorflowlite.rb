class Tensorflowlite < Formula
  desc "Open Source Machine Learning Framework for Everyone"
  homepage "https://tensorflow.org"
  url "https://github.com/tensorflow/tensorflow/archive/refs/tags/v2.12.0.tar.gz"
  sha256 "c030cb1905bff1d2446615992aad8d8d85cbe90c4fb625cee458c63bf466bc8e"
  license "Apache-2.0"
  head "https://github.com/tensorflow/tensorflow.git", branch: "master"

  depends_on "cmake" => :build

  patch :p1, <<~EOP
    --- a/tensorflow/lite/core/interpreter.cc
    +++ b/tensorflow/lite/core/interpreter.cc
    @@ -445,8 +445,10 @@
     }

     TfLiteStatus Interpreter::ReportTelemetrySettings(const char* setting_name) {
    +#ifdef TF_LITE_TENSORFLOW_PROFILER
       telemetry::TelemetryReportSettings(context_, setting_name,
                                          telemetry_data_.get());
    +#endif //TFLITE_TENSORFLOW_PROFILER
       return kTfLiteOk;
     }

    --- a/tensorflow/lite/core/subgraph.cc
    +++ b/tensorflow/lite/core/subgraph.cc
    @@ -1382,7 +1382,9 @@

     TfLiteStatus Subgraph::Invoke() {
       auto status = InvokeImpl();
    +#ifdef TF_LITE_TENSORFLOW_PROFILER
       telemetry::TelemetryReportEvent(&context_, "Invoke", status);
    +#endif //TFLITE_TENSORFLOW_PROFILER
       return status;
     }
     TfLiteStatus Subgraph::InvokeImpl() {
    @@ -1966,7 +1968,9 @@

     TfLiteStatus Subgraph::ModifyGraphWithDelegate(TfLiteDelegate* delegate) {
       auto status = ModifyGraphWithDelegateImpl(delegate);
    +#ifdef TF_LITE_TENSORFLOW_PROFILER
       telemetry::TelemetryReportEvent(&context_, "ModifyGraphWithDelegate", status);
    +#endif //TFLITE_TENSORFLOW_PROFILER
       return status;
     }

  EOP

  def install
    if OS.linux?
      # Utility needed for static repack
      (buildpath/"flatten-archives.sh").write <<~EOQ
        #!/usr/bin/env bash

        if [[ $# -lt 2 ]]; then
        	echo "Usage: $0 out.a in1.a in2.a ... inN.a"
        	exit 1
        fi

        out_file="$1"
        shift

        if ! [[ "$out_file" =~ \.a$ ]]; then
        	echo "$out_file must be an archive (.a) file"
        	exit 1
        fi

        mkdir -p `dirname "$out_file"`

        for src in "$@"; do
        	if ! [[ "$src" =~ \.a$ ]]; then
        		echo "input $src is not an archive (.a) file"
        		exit 1
        	fi
        	declare -A members
        	for member in `ar t $src`; do
        		((members[$member]++))
        		ar xN ${members[$member]} "$src" "$member"
        		ar q "$out_file" "$member"
        		rm "$member"
        	done
        	unset members
        done
        ranlib $out_file
      EOQ

      chmod 0755, "flatten-archives.sh"

      # static build
      mkdir "builddir_static"
      system "cmake", "-DTFLITE_C_BUILD_SHARED_LIBS=OFF", "-Bbuilddir_static", "-Stensorflow/lite/c"
      system "cmake", "--build", "builddir_static", "-j8"

      # repack static build into complete archive
      system "bash", "-c",
        "find builddir_static/_deps -name '*.a' -print0 | xargs -0 ./flatten-archives.sh libtensorflowlite_c.a builddir_static/libtensorflowlite_c.a builddir_static/tensorflow-lite/libtensorflow-lite.a builddir_static/pthreadpool/libpthreadpool.a"
      lib.install "libtensorflowlite_c.a"
    end
    # end linux-only static build

    # dynamic build
    mkdir "builddir_dynamic"
    system "cmake", "-Bbuilddir_dynamic", "-Stensorflow/lite/c"
    system "cmake", "--build", "builddir_dynamic", "-j8"
    lib.install Dir["builddir_dynamic/libtensorflowlite_c.*"]

    mkdir_p include/"tensorflow/lite/c"
    mkdir_p include/"tensorflow/lite/core/c"

    include.install "tensorflow/lite/builtin_ops.h" => "tensorflow/lite/builtin_ops.h"
    include.install "tensorflow/lite/c/c_api.h" => "tensorflow/lite/c/c_api.h"
    include.install "tensorflow/lite/c/c_api_experimental.h" => "tensorflow/lite/c/c_api_experimental.h"
    include.install "tensorflow/lite/c/c_api_for_testing.h" => "tensorflow/lite/c/c_api_for_testing.h"
    include.install "tensorflow/lite/c/c_api_types.h" => "tensorflow/lite/c/c_api_types.h"
    include.install "tensorflow/lite/c/common.h" => "tensorflow/lite/c/common.h"
    include.install "tensorflow/lite/core/c/c_api.h" => "tensorflow/lite/core/c/c_api.h"
    include.install "tensorflow/lite/core/c/c_api_types.h" => "tensorflow/lite/core/c/c_api_types.h"
    include.install "tensorflow/lite/core/c/c_api_experimental.h" => "tensorflow/lite/core/c/c_api_experimental.h"
    include.install "tensorflow/lite/core/c/common.h" => "tensorflow/lite/core/c/common.h"
  end
end
