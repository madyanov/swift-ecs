#if !canImport(ObjectiveC)
import XCTest

extension EntityIdentifiersPoolTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__EntityIdentifiersPoolTests = [
        ("test_flush_method", test_flush_method),
        ("test_free_method", test_free_method),
        ("test_take_method", test_take_method),
    ]
}

extension EntityTraitSetTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__EntityTraitSetTests = [
        ("test_match_one_excluded_method", test_match_one_excluded_method),
        ("test_match_one_required_method", test_match_one_required_method),
        ("test_match_two_excluded_method", test_match_two_excluded_method),
        ("test_match_two_required_method", test_match_two_required_method),
    ]
}

extension NexusComponentTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__NexusComponentTests = [
        ("test_component_replacing", test_component_replacing),
        ("test_get_method_and_component_changing", test_get_method_and_component_changing),
        ("test_has_method", test_has_method),
        ("test_numberOfComponents_property", test_numberOfComponents_property),
        ("test_remove_method", test_remove_method),
    ]
}

extension NexusEntityTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__NexusEntityTests = [
        ("test_makeEntity_method", test_makeEntity_method),
        ("test_numberOfEntities_and_removeEntity_method", test_numberOfEntities_and_removeEntity_method),
    ]
}

extension NexusTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__NexusTests = [
        ("test_systems_synchronization", test_systems_synchronization),
    ]
}

extension SparseSetBakedSystemTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__SparseSetBakedSystemTests = [
        ("test_component_removing_while_iterating", test_component_removing_while_iterating),
        ("test_systems_synchronization", test_systems_synchronization),
    ]
}

extension UnorderedSparseSetTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__UnorderedSparseSetTests = [
        ("test_contains_method", test_contains_method),
        ("test_count_and_isEmpty_properties", test_count_and_isEmpty_properties),
        ("test_elements_and_keys_properties", test_elements_and_keys_properties),
        ("test_get_method", test_get_method),
        ("test_insert_method", test_insert_method),
        ("test_remove_method", test_remove_method),
        ("test_removeAll_method", test_removeAll_method),
        ("test_search_method", test_search_method),
        ("test_sequence_implementation", test_sequence_implementation),
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(EntityIdentifiersPoolTests.__allTests__EntityIdentifiersPoolTests),
        testCase(EntityTraitSetTests.__allTests__EntityTraitSetTests),
        testCase(NexusComponentTests.__allTests__NexusComponentTests),
        testCase(NexusEntityTests.__allTests__NexusEntityTests),
        testCase(NexusTests.__allTests__NexusTests),
        testCase(SparseSetBakedSystemTests.__allTests__SparseSetBakedSystemTests),
        testCase(UnorderedSparseSetTests.__allTests__UnorderedSparseSetTests),
    ]
}
#endif
