///
/// Game Start Event
///

/// This is just a testing helper for GitHub automations.
/// (See Ken's Test Framework (KTF) single object and single script assets)

if os_get_config() == "Test" {
    if (global.ktf.enabled && (not instance_exists(obj_ktf_stepper))) {
        instance_create_depth(0,0,0,obj_ktf_stepper);
    }
}
