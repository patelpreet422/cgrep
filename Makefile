TARGET := cgrep
HEADERS := `llvm-config --includedir`
WARNINGS := -Wall -Wextra -pedantic
CXXFLAGS := $(WARNINGS) -std=c++14 -fno-exceptions -fno-rtti -O3 -Os
LDFLAGS := `llvm-config --ldflags`

# lorder cgrep /llvm/lib/libclang*.a | tsort | sed 's/\/llvm\/lib\/lib/-l/g'
CLANG_LIBS := \
	-lclangFrontendTool \
	-lclangRewriteFrontend \
	-lclangDynamicASTMatchers \
	-lclangTooling \
	-lclangFrontend \
	-lclangToolingCore \
	-lclangASTMatchers \
	-lclangParse \
	-lclangDriver \
	-lclangSerialization \
	-lclangRewrite \
	-lclangSema \
	-lclangEdit \
	-lclangAnalysis \
	-lclangAST \
	-lclangLex \
	-lclangBasic

LIBS := `llvm-config --libs --system-libs` -lclang

all: cgrep

.phony: clean
.phony: run

clean:
	rm $(TARGET) || echo -n ""

cgrep: $(TARGET).cpp
	$(CXX) $(HEADERS) $(LDFLAGS) $(CXXFLAGS) $(TARGET).cpp $(LIBS) -o $(TARGET)
