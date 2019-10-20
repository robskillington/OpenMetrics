BUILD := $(abspath ./bin)
BINARIES :=         \
	openmetricstest \

# To test "echo": 
# make test-impl cmd-parser-text=echo
.PHONY: test-impl
test-impl: openmetricstest
	$(BUILD)/openmetricstest -cmd-parser-text $(cmd-parser-text)

.PHONY: generate-proto
generate-proto: setup
	@echo Generating protobuf
	protoc --go_out=$(BUILD) ./proto/*.proto

.PHONY: setup
setup:
	mkdir -p $(BUILD)

.PHONY: binaries
binaries: $(BINARIES)

define BINARY_RULES

.PHONY: $(BINARY)
$(BINARY): setup
	@echo Building $(BINARY)
	go build -o $(BUILD)/$(BINARY) ./src/cmd/$(BINARY)/.

endef

$(foreach BINARY,$(BINARIES),$(eval $(BINARY_RULES)))
