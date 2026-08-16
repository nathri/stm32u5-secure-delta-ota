add_executable(bootloader
    Core/Src/main.c
    Core/Startup/startup_stub.s
)

target_include_directories(bootloader PRIVATE Core/Inc)

target_link_options(bootloader PRIVATE
    -T${CMAKE_CURRENT_SOURCE_DIR}/STM32U575XX_BOOTLOADER.ld
    -nostdlib
)

set_target_properties(bootloader PROPERTIES SUFFIX ".elf")

add_custom_command(TARGET bootloader POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} -O binary $<TARGET_FILE:bootloader> ${CMAKE_CURRENT_BINARY_DIR}/bootloader.bin
    COMMAND ${CMAKE_SIZE} $<TARGET_FILE:bootloader>
)
