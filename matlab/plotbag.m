% Create a bag file object with the file name
% by omitting the semicolon this deisplays some information about
% the bag file
bag = rosbag('catkin_ws/src/mrc_hw3/data/myturtle.bag')

% Display a list of the topics and message types in the bag file
bag.AvailableTopics

% Since the messages on topic turtle1/pose are of type Twist,
% let's see some attributes of the Twist message
msg_pose = rosmessage('turtlesim/pose')
showdetails(msg_pose)

% Get just the topic we are interested in 
bagselect = select(bag,'Topic','turtle1/pose');

% Create a time series object based on the fields of the turtlesim/Pose
% message we are interested in
ts = timeseries(bagselect,'X','Y','Theta','LinearVelocity','AngularVelocity');

%% Plot figures from timeseries data

% Figure 1: X and Y position of turtle
figure(1)
plot(ts.data(:,1),ts.data(:,2))
title('Turtle 1 Position')
xlabel('X position [units]')
ylabel('Y position [units]')
saveas(gcf, 'pose_xy.png')

% Figure 2: Theta value of turtle over time
figure(2)
plot(ts.time, ts.data(:,3))
title('Turtle Heading Angle Over Time')
xlabel('Time [s]')
ylabel('Theta [rad]')
%note: record was left on for too long, axis limited to view data
xlim([1.5242496e9,1.5242497e9])
saveas(gcf, 'pose_theta.png')


% Figure 3: quiver plot
x = ts.data(:,1);
y = ts.data(:,2);
vel = ts.data(:,4);
th = ts.data(:,3);

u = vel.*cos(th);
v = vel.*sin(th);
ii = 1:10:length(x); % Decimate the dta so it only plots every 10th point
quiver(x(ii),y(ii),u(ii),v(ii))
title('Quiver Plot of Turtle1')
xlabel('X positition [units]')
ylabel('Y Position [units]')
saveas(gcf,'pose_quiver.png')
