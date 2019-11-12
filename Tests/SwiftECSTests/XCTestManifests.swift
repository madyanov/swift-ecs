#if !canImport(ObjectiveC)
import XCTest

extension CleanupSystemSystemTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__CleanupSystemSystemTests = [
        ("test_component_removing", test_component_removing),
    ]
}

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
        ("test_matching_with_one_excluded_component", test_matching_with_one_excluded_component),
        ("test_matching_with_one_required_component", test_matching_with_one_required_component),
        ("test_matching_with_two_excluded_components", test_matching_with_two_excluded_components),
        ("test_matching_with_two_required_components", test_matching_with_two_required_components),
    ]
}

extension NexusComponentTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__NexusComponentTests = [
        ("test_all_entity_components_fetching", test_all_entity_components_fetching),
        ("test_component_removing", test_component_removing),
        ("test_component_replacing", test_component_replacing),
        ("test_get_method_and_component_updating", test_get_method_and_component_updating),
        ("test_has_method", test_has_method),
        ("test_numberOfComponents_property", test_numberOfComponents_property),
    ]
}

extension NexusEntityTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__NexusEntityTests = [
        ("test_entity_creation", test_entity_creation),
        ("test_numberOfEntities_property", test_numberOfEntities_property),
    ]
}

extension NexusSystemTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__NexusSystemTests = [
        ("test_non_existing_entity_removing", test_non_existing_entity_removing),
        ("test_system_synchronization", test_system_synchronization),
    ]
}

extension SparseSetBakedSystemTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__SparseSetBakedSystemTests = [
        ("test_component_removing_while_iterating", test_component_removing_while_iterating),
        ("test_system_synchronization", test_system_synchronization),
    ]
}

extension SparseSetTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__SparseSetTests = [
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
        testCase(CleanupSystemSystemTests.__allTests__CleanupSystemSystemTests),
        testCase(EntityIdentifiersPoolTests.__allTests__EntityIdentifiersPoolTests),
        testCase(EntityTraitSetTests.__allTests__EntityTraitSetTests),
        testCase(NexusComponentTests.__allTests__NexusComponentTests),
        testCase(NexusEntityTests.__allTests__NexusEntityTests),
        testCase(NexusSystemTests.__allTests__NexusSystemTests),
        testCase(SparseSetBakedSystemTests.__allTests__SparseSetBakedSystemTests),
        testCase(SparseSetTests.__allTests__SparseSetTests),
    ]
}
#endif
