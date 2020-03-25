%% LOAD PRE-PROCESSED DATA

% data from arm-munted phone
data_arm = load('data_arm.mat', 'summary');
arm_ay_max = data_arm.summary(6,:); % Acceleration-Y-Max

% data from waist-munted phone
data_waist = load('data_waist.mat', 'summary');
waist_ay_max = data_waist.summary(6,:); % Acceleration-Y-Max

%% POSTURES: P1-P6

% Total Flexion
ratio = (arm_ay_max(1:6) - arm_ay_max(2))/(arm_ay_max(1) - arm_ay_max(2));
ratio = max( min(ratio,1), -1 );
total_flex_1 = acos(ratio) * 180 / pi;

% Trunk Flexion
ratio = (waist_ay_max(1:6) - waist_ay_max(6))/(waist_ay_max(1) - waist_ay_max(6));
ratio = max( min(ratio,1), -1 );
trunk_flex_1 = acos(ratio) * 180 / pi;

% Shoulder Flexion
shoulder_flex_1 = total_flex_1 + trunk_flex_1;

%% POSTURES: P7-P10

% Total Flexion
ratio = (arm_ay_max(7:16) - arm_ay_max(14))/(arm_ay_max(11) - arm_ay_max(14));
ratio = max( min(ratio,1), -1 );
total_flex_2 = acos(ratio) * 180 / pi;

% Trunk Flexion
ratio = (waist_ay_max(7:16) - waist_ay_max(16))/(waist_ay_max(7) - waist_ay_max(16));
ratio = max( min(ratio,1), -1 );
trunk_flex_2 = acos(ratio) * 180 / pi;

% Shoulder Flexion
shoulder_flex_2 = total_flex_2 + trunk_flex_2;

%% PUT ALL TOGETHER

total_flex = [total_flex_1, total_flex_2];
trunk_flex = [trunk_flex_1, trunk_flex_2];
shoulder_flex = [shoulder_flex_1, shoulder_flex_2];

%% CLEAR

clear data_arm data_waist arm_ay_max waist_ay_max ratio ...
    total_flex_1 total_flex_2 trunk_flex_1 trunk_flex_2 ...
    shoulder_flex_1 shoulder_flex_2;