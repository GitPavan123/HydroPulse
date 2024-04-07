// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HomeAutomation {
    
    mapping(address => bool) public authorizedDevices;
    event DeviceToggled(address indexed device, bool status);

    modifier onlyAuthorized() {
        require(authorizedDevices[msg.sender], "Device not authorized");
        _;
    }

    function toggleDevice() public onlyAuthorized {
        // Toggle device logic
        emit DeviceToggled(msg.sender, true); // Replace with actual logic
    }

    function authorizeDevice(address _device) public {
        authorizedDevices[_device] = true;
    }

    function deauthorizeDevice(address _device) public {
       authorizedDevices[_device] = false;
    }
}