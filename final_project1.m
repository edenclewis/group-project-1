classdef final_project1 < matlab.ui.componentcontainer.ComponentContainer

    % Properties that correspond to underlying components
    properties (Access = private, Transient, NonCopyable)
        GridLayout          matlab.ui.container.GridLayout
        image3              matlab.ui.control.Image
        RestartButton       matlab.ui.control.Button
        playagain           matlab.ui.control.Label
        Image               matlab.ui.control.Image
        StarttheGameButton  matlab.ui.control.Button
        directions          matlab.ui.control.TextArea
        displaycorrectword  matlab.ui.control.Label
        ImpressiveLabel     matlab.ui.control.Label
        restartButton       matlab.ui.control.Button
        YouloseLabel        matlab.ui.control.Label
        row_5_column_4      matlab.ui.control.Label
        row_4_column_4      matlab.ui.control.Label
        row_3_column_4      matlab.ui.control.Label
        row_2_column_4      matlab.ui.control.Label
        row_1_column_4      matlab.ui.control.Label
        Image2              matlab.ui.control.Image
        row_5_column_1      matlab.ui.control.Label
        row_4_column_1      matlab.ui.control.Label
        row_3_column_1      matlab.ui.control.Label
        row_2_column_1      matlab.ui.control.Label
        row_1_column_1      matlab.ui.control.Label
        edit_field          matlab.ui.control.EditField
        submitButton        matlab.ui.control.Button
        row_5_column_5      matlab.ui.control.Label
        row_4_column_5      matlab.ui.control.Label
        row_3_column_5      matlab.ui.control.Label
        row_2_column_5      matlab.ui.control.Label
        row_1_column_5      matlab.ui.control.Label
        row_5_column_3      matlab.ui.control.Label
        row_4_column_3      matlab.ui.control.Label
        row_3_column_3      matlab.ui.control.Label
        row_2_column_3      matlab.ui.control.Label
        row_1_column_3      matlab.ui.control.Label
        row_5_column_2      matlab.ui.control.Label
        row_4_column_2      matlab.ui.control.Label
        row_3_column_2      matlab.ui.control.Label
        row_2_column_2      matlab.ui.control.Label
        row_1_column_2      matlab.ui.control.Label
        guess_the_word      matlab.ui.control.Label
    end



    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: submitButton
        function submitButtonPushed(comp, event)
    %%% this function runs whenever the user presses the submit button%%%
    persistent pressCount  %% the persistent function retains memory of the amount of time the button was previously pressed
    if isempty(pressCount) %% if the button was not pressed, the press count is 0
        pressCount = 0;
    end
    
    pressCount = pressCount + 1; %% if the button was pressed, add one to the pressCount
    
    valueMatrix = upper(comp.edit_field.Value(1, :)); % creates matrix/vector that stores the 'guess' that user types in
    
    row = pressCount; %% creates variable, row, that is representative with the amount of times the submit button has been pressed 
    
    if row <= 5  % make sure the row number is not greater than 5 (user only has 5 attempts to guess the word)
        for col = 1:5  % creates variable col to represent the columns, and loops through columns 1 to 5 (accounting for amount of letters there are in the word)
            comp.(['row_' num2str(row) '_column_' num2str(col)]).Text = valueMatrix(col); %% sets the letter the user guessed to be input into a specific box in the grid configuration 
        end
    end


WORDS_array = []; %% creates empty array to input the potential correct words into 
    fid = fopen('WORDS.txt', 'r'); % Opens file with list of 3102 words
    while ~feof(fid) % while the file is opened 
        line = fgetl(fid); % read each word in the list 
        WORDS_array = [WORDS_array; line]; % add each word in the list to a 3102 x 1 vector 
    end
   
    global rand_num; %% makes ran_num a global variable that can be used outside the function
    if row == 1 %% if its the first time button is pressed
        rand_num = randi(3102); % pick a random number between 1-3102
    end

correct_word = WORDS_array(rand_num, :); %% make the correct word the word that is in the position that the random number picked (always will be 1-3102:1)
    green_color = [0.55 0.85 0.55]; %% creates a green color
    yellow_color = [0.95 0.95 0.35]; %% creates a yellow color
    grey_color = [0.7 0.7 0.7]; %% creates a grey color
    green_letters = [0 0 0 0 0]; %% initializes a zeros vector
    yellow_letters = [0 0 0 0 0]; %% initalizes a zeros vector
    correct_word2 = correct_word;
    for j = 1:5 %% goes through each letter of the word
        if upper(correct_word2(j)) == upper(comp.edit_field.Value(j)) %% if the correct letter is equal to the guessed letter
            correct_word2(j) = '!'; %% sets correct_word2 of j to an explanation mark 
            green_letters(j) = 1; %% changes value of green_letters vector to 1
        end
    end
    for j = 1:5 %% goes through each letter of the word
        if green_letters(j) == 1 %% if the value in the green_letters vector is equal to 1
            continue; %% continue beyond this for-loop
        end

        if ismember(upper(comp.edit_field.Value(j)), upper(correct_word2(green_letters == 0))) %% if the letter from the users guess is in the correct word but not in the correct place ADD SOMETHING ABOUT HOW IT'S THE FIRST TIME THE LETTER APPEARS 
            match_positions = find(upper(correct_word2) == upper(comp.edit_field.Value(j))); %% find position in correct word where the letter is the same as the letter in the guessed word 
            correct_word2(match_positions) = '!'; %% set correct_word2 of that position to explaination mark 
            yellow_letters(j) = 1; %% change the value of the yellow_letters vector to 1
        end 
    end
    for j = 1:5 %% goes through each letter of the word
        if green_letters(j) == 1   %% if the value of the green_letters vector is equal to 1 
            set(comp.(['row_' num2str(row) '_column_' num2str(j)]),'BackgroundColor', green_color); %% set the specific box in the grid configuration to a backrgound color of green 
            continue; %% continue beyond this loop
        end

        if yellow_letters(j) == 1 %if the value of the yellow_letters vector is equal to 1 
            set(comp.(['row_' num2str(row) '_column_' num2str(j)]), 'BackgroundColor', yellow_color); %% set the specific box in the grid configuration to a backrgound color of yellow
            continue; %% continue beyond this loop
        end

        set(comp.(['row_' num2str(row) '_column_' num2str(j)]), 'BackgroundColor', grey_color); %% if it is not yellow or green set the specific box in the grid configuration to a backrgound color of grey 
    end
    
    comp.edit_field.Value = ''; %% resets the edit field value to be empty

    pause(1.0); %% pauses for one second

    if green_letters == 1 %% if the user corrected guessed the word
        comp.ImpressiveLabel.Visible = 'on'; %% display a label that says 'impressive'
        pressCount = 0; %% reset the amount of time the user has pressed the button to zero
        pause(1.5); %% pause for 1.5 second
        comp.ImpressiveLabel.Visible = 'off'; %% turns off impressive label 
        comp.playagain.Visible = 'on'; %% turn on the play again label 
        comp.RestartButton.Visible = 'on';%% turn on the restart button label 
        comp.image3.Visible = 'on'; %% turns on our cracked logo 
    elseif row == 5 %% if the user didn't guess the word
        comp.displaycorrectword.Text = correct_word; %% makes the text of the label the correct word
        comp.displaycorrectword.Visible = 'on'; %% displays the correct word label
        pause(1.5); %% pauses for 1.5 seconds
        comp.displaycorrectword.Visible = 'off'; %% turns the correct word label off
        comp.YouloseLabel.Visible = 'on'; %% display label that says 'you lose'
        comp.restartButton.Visible = 'on'; %% dispplay label that allows user to restart
        pressCount = 0; %% reset the amount of time the user has pressed the button to zero
    end
        
        end

        % Button pushed function: restartButton
        function restartButtonPushed(comp, event)

         %% if restart button is pressed 
        comp.YouloseLabel.Visible = 'off'; %% turn off the 'you lose' label
        comp.restartButton.Visible = 'off'; %% turn off the restart button label 
        white_color = [1 1 1]; %% variable to represent white color 
        blank_grid = ''; %% create a blank grid variable that has no words in the grid
        for i = 1:5 % go through rows
            for j = 1:5 % go through columns
                set(comp.(['row_' num2str(i) '_column_' num2str(j)]),'BackgroundColor', white_color); %% sets background color of each row/column to white
                set(comp.(['row_' num2str(i) '_column_' num2str(j)]),'Text', blank_grid); %% sets the text within each row/column to blank 
            end
        end
       
        end

        % Button pushed function: StarttheGameButton
        function StarttheGameButtonPushed(comp, event)
            %% if start the game button is pushed 
            comp.directions.Visible = 'off'; %% turns off the label that displays the directions of the game
            comp.StarttheGameButton.Visible = 'off'; %% turns off the label that displays the start game button
            comp.Image.Visible = 'off'; %% turns off ouf logo image
            comp.directions.Editable = 'off'; %% turns off the editability of the directions 

        end

        % Button pushed function: RestartButton
        function RestartButtonPushed(comp, event)
        comp.image3.Visible = 'off'; %% turn off the logo image 
        comp.playagain.Visible = 'off'; %% turn off the play again label 
        comp.RestartButton.Visible = 'off'; %% turn off the play again label 
        white_color = [1 1 1]; %% variable to represent white color 
        blank_grid = ''; %% create a blank grid variable that has no words in the grid
        for i = 1:5 % go through rows
            for j = 1:5 % go through columns
                set(comp.(['row_' num2str(i) '_column_' num2str(j)]),'BackgroundColor', white_color); %% sets background color of each row/column to white
                set(comp.(['row_' num2str(i) '_column_' num2str(j)]),'Text', blank_grid); %% sets the text within each row/column to blank 
            end
        end
        end
    end

    methods (Access = protected)
        
        % Code that executes when the value of a public property is changed
        function update(comp)
            % Use this function to update the underlying components
            
        end

        % Create the underlying components
        function setup(comp)

            % Get the file path for locating images
            pathToMLAPP = fileparts(mfilename('fullpath'));

            comp.Position = [1 1 624 475];

            % Create GridLayout
            comp.GridLayout = uigridlayout(comp);
            comp.GridLayout.ColumnWidth = {'5x', '2x', '2x', '2x', '2x', '2x'};
            comp.GridLayout.RowHeight = {'1x', '1x', '1x', '1x', '1x'};

            % Create guess_the_word
            comp.guess_the_word = uilabel(comp.GridLayout);
            comp.guess_the_word.BackgroundColor = [1 1 1];
            comp.guess_the_word.HorizontalAlignment = 'center';
            comp.guess_the_word.WordWrap = 'on';
            comp.guess_the_word.FontName = 'ZapfDingbats';
            comp.guess_the_word.FontSize = 14;
            comp.guess_the_word.FontWeight = 'bold';
            comp.guess_the_word.Layout.Row = 3;
            comp.guess_the_word.Layout.Column = 1;
            comp.guess_the_word.Text = {'Guess the word and check your answer by pressing the submit button.'; 'lowercase letters only!'};

            % Create row_1_column_2
            comp.row_1_column_2 = uilabel(comp.GridLayout);
            comp.row_1_column_2.BackgroundColor = [1 1 1];
            comp.row_1_column_2.HorizontalAlignment = 'center';
            comp.row_1_column_2.FontName = 'ZapfDingbats';
            comp.row_1_column_2.FontSize = 36;
            comp.row_1_column_2.FontWeight = 'bold';
            comp.row_1_column_2.Layout.Row = 1;
            comp.row_1_column_2.Layout.Column = 3;
            comp.row_1_column_2.Text = '';

            % Create row_2_column_2
            comp.row_2_column_2 = uilabel(comp.GridLayout);
            comp.row_2_column_2.BackgroundColor = [1 1 1];
            comp.row_2_column_2.HorizontalAlignment = 'center';
            comp.row_2_column_2.FontName = 'ZapfDingbats';
            comp.row_2_column_2.FontSize = 36;
            comp.row_2_column_2.FontWeight = 'bold';
            comp.row_2_column_2.Layout.Row = 2;
            comp.row_2_column_2.Layout.Column = 3;
            comp.row_2_column_2.Text = '';

            % Create row_3_column_2
            comp.row_3_column_2 = uilabel(comp.GridLayout);
            comp.row_3_column_2.BackgroundColor = [1 1 1];
            comp.row_3_column_2.HorizontalAlignment = 'center';
            comp.row_3_column_2.FontName = 'ZapfDingbats';
            comp.row_3_column_2.FontSize = 36;
            comp.row_3_column_2.FontWeight = 'bold';
            comp.row_3_column_2.Layout.Row = 3;
            comp.row_3_column_2.Layout.Column = 3;
            comp.row_3_column_2.Text = '';

            % Create row_4_column_2
            comp.row_4_column_2 = uilabel(comp.GridLayout);
            comp.row_4_column_2.BackgroundColor = [1 1 1];
            comp.row_4_column_2.HorizontalAlignment = 'center';
            comp.row_4_column_2.FontName = 'ZapfDingbats';
            comp.row_4_column_2.FontSize = 36;
            comp.row_4_column_2.FontWeight = 'bold';
            comp.row_4_column_2.Layout.Row = 4;
            comp.row_4_column_2.Layout.Column = 3;
            comp.row_4_column_2.Text = '';

            % Create row_5_column_2
            comp.row_5_column_2 = uilabel(comp.GridLayout);
            comp.row_5_column_2.BackgroundColor = [1 1 1];
            comp.row_5_column_2.HorizontalAlignment = 'center';
            comp.row_5_column_2.FontName = 'ZapfDingbats';
            comp.row_5_column_2.FontSize = 36;
            comp.row_5_column_2.FontWeight = 'bold';
            comp.row_5_column_2.Layout.Row = 5;
            comp.row_5_column_2.Layout.Column = 3;
            comp.row_5_column_2.Text = '';

            % Create row_1_column_3
            comp.row_1_column_3 = uilabel(comp.GridLayout);
            comp.row_1_column_3.BackgroundColor = [1 1 1];
            comp.row_1_column_3.HorizontalAlignment = 'center';
            comp.row_1_column_3.FontName = 'ZapfDingbats';
            comp.row_1_column_3.FontSize = 36;
            comp.row_1_column_3.FontWeight = 'bold';
            comp.row_1_column_3.Layout.Row = 1;
            comp.row_1_column_3.Layout.Column = 4;
            comp.row_1_column_3.Text = '';

            % Create row_2_column_3
            comp.row_2_column_3 = uilabel(comp.GridLayout);
            comp.row_2_column_3.BackgroundColor = [1 1 1];
            comp.row_2_column_3.HorizontalAlignment = 'center';
            comp.row_2_column_3.FontName = 'ZapfDingbats';
            comp.row_2_column_3.FontSize = 36;
            comp.row_2_column_3.FontWeight = 'bold';
            comp.row_2_column_3.Layout.Row = 2;
            comp.row_2_column_3.Layout.Column = 4;
            comp.row_2_column_3.Text = '';

            % Create row_3_column_3
            comp.row_3_column_3 = uilabel(comp.GridLayout);
            comp.row_3_column_3.BackgroundColor = [1 1 1];
            comp.row_3_column_3.HorizontalAlignment = 'center';
            comp.row_3_column_3.FontName = 'ZapfDingbats';
            comp.row_3_column_3.FontSize = 36;
            comp.row_3_column_3.FontWeight = 'bold';
            comp.row_3_column_3.Layout.Row = 3;
            comp.row_3_column_3.Layout.Column = 4;
            comp.row_3_column_3.Text = '';

            % Create row_4_column_3
            comp.row_4_column_3 = uilabel(comp.GridLayout);
            comp.row_4_column_3.BackgroundColor = [1 1 1];
            comp.row_4_column_3.HorizontalAlignment = 'center';
            comp.row_4_column_3.FontName = 'ZapfDingbats';
            comp.row_4_column_3.FontSize = 36;
            comp.row_4_column_3.FontWeight = 'bold';
            comp.row_4_column_3.Layout.Row = 4;
            comp.row_4_column_3.Layout.Column = 4;
            comp.row_4_column_3.Text = '';

            % Create row_5_column_3
            comp.row_5_column_3 = uilabel(comp.GridLayout);
            comp.row_5_column_3.BackgroundColor = [1 1 1];
            comp.row_5_column_3.HorizontalAlignment = 'center';
            comp.row_5_column_3.FontName = 'ZapfDingbats';
            comp.row_5_column_3.FontSize = 36;
            comp.row_5_column_3.FontWeight = 'bold';
            comp.row_5_column_3.Layout.Row = 5;
            comp.row_5_column_3.Layout.Column = 4;
            comp.row_5_column_3.Text = '';

            % Create row_1_column_5
            comp.row_1_column_5 = uilabel(comp.GridLayout);
            comp.row_1_column_5.BackgroundColor = [1 1 1];
            comp.row_1_column_5.HorizontalAlignment = 'center';
            comp.row_1_column_5.FontName = 'ZapfDingbats';
            comp.row_1_column_5.FontSize = 36;
            comp.row_1_column_5.FontWeight = 'bold';
            comp.row_1_column_5.Layout.Row = 1;
            comp.row_1_column_5.Layout.Column = 6;
            comp.row_1_column_5.Text = '';

            % Create row_2_column_5
            comp.row_2_column_5 = uilabel(comp.GridLayout);
            comp.row_2_column_5.BackgroundColor = [1 1 1];
            comp.row_2_column_5.HorizontalAlignment = 'center';
            comp.row_2_column_5.FontName = 'ZapfDingbats';
            comp.row_2_column_5.FontSize = 36;
            comp.row_2_column_5.FontWeight = 'bold';
            comp.row_2_column_5.Layout.Row = 2;
            comp.row_2_column_5.Layout.Column = 6;
            comp.row_2_column_5.Text = '';

            % Create row_3_column_5
            comp.row_3_column_5 = uilabel(comp.GridLayout);
            comp.row_3_column_5.BackgroundColor = [1 1 1];
            comp.row_3_column_5.HorizontalAlignment = 'center';
            comp.row_3_column_5.FontName = 'ZapfDingbats';
            comp.row_3_column_5.FontSize = 36;
            comp.row_3_column_5.FontWeight = 'bold';
            comp.row_3_column_5.Layout.Row = 3;
            comp.row_3_column_5.Layout.Column = 6;
            comp.row_3_column_5.Text = '';

            % Create row_4_column_5
            comp.row_4_column_5 = uilabel(comp.GridLayout);
            comp.row_4_column_5.BackgroundColor = [1 1 1];
            comp.row_4_column_5.HorizontalAlignment = 'center';
            comp.row_4_column_5.FontName = 'ZapfDingbats';
            comp.row_4_column_5.FontSize = 36;
            comp.row_4_column_5.FontWeight = 'bold';
            comp.row_4_column_5.Layout.Row = 4;
            comp.row_4_column_5.Layout.Column = 6;
            comp.row_4_column_5.Text = '';

            % Create row_5_column_5
            comp.row_5_column_5 = uilabel(comp.GridLayout);
            comp.row_5_column_5.BackgroundColor = [1 1 1];
            comp.row_5_column_5.HorizontalAlignment = 'center';
            comp.row_5_column_5.FontName = 'ZapfDingbats';
            comp.row_5_column_5.FontSize = 36;
            comp.row_5_column_5.FontWeight = 'bold';
            comp.row_5_column_5.Layout.Row = 5;
            comp.row_5_column_5.Layout.Column = 6;
            comp.row_5_column_5.Text = '';

            % Create submitButton
            comp.submitButton = uibutton(comp.GridLayout, 'push');
            comp.submitButton.ButtonPushedFcn = matlab.apps.createCallbackFcn(comp, @submitButtonPushed, true);
            comp.submitButton.BackgroundColor = [0.5882 0.8902 0.5882];
            comp.submitButton.FontName = 'ZapfDingbats';
            comp.submitButton.Layout.Row = 5;
            comp.submitButton.Layout.Column = 1;
            comp.submitButton.Text = 'submit';

            % Create edit_field
            comp.edit_field = uieditfield(comp.GridLayout, 'text');
            comp.edit_field.CharacterLimits = [0 5];
            comp.edit_field.InputType = 'letters';
            comp.edit_field.HorizontalAlignment = 'center';
            comp.edit_field.FontName = 'ZapfDingbats';
            comp.edit_field.FontSize = 18;
            comp.edit_field.Layout.Row = 4;
            comp.edit_field.Layout.Column = 1;

            % Create row_1_column_1
            comp.row_1_column_1 = uilabel(comp.GridLayout);
            comp.row_1_column_1.BackgroundColor = [1 1 1];
            comp.row_1_column_1.HorizontalAlignment = 'center';
            comp.row_1_column_1.FontName = 'ZapfDingbats';
            comp.row_1_column_1.FontSize = 36;
            comp.row_1_column_1.FontWeight = 'bold';
            comp.row_1_column_1.Layout.Row = 1;
            comp.row_1_column_1.Layout.Column = 2;
            comp.row_1_column_1.Text = '';

            % Create row_2_column_1
            comp.row_2_column_1 = uilabel(comp.GridLayout);
            comp.row_2_column_1.BackgroundColor = [1 1 1];
            comp.row_2_column_1.HorizontalAlignment = 'center';
            comp.row_2_column_1.FontName = 'ZapfDingbats';
            comp.row_2_column_1.FontSize = 36;
            comp.row_2_column_1.FontWeight = 'bold';
            comp.row_2_column_1.Layout.Row = 2;
            comp.row_2_column_1.Layout.Column = 2;
            comp.row_2_column_1.Text = '';

            % Create row_3_column_1
            comp.row_3_column_1 = uilabel(comp.GridLayout);
            comp.row_3_column_1.BackgroundColor = [1 1 1];
            comp.row_3_column_1.HorizontalAlignment = 'center';
            comp.row_3_column_1.FontName = 'ZapfDingbats';
            comp.row_3_column_1.FontSize = 36;
            comp.row_3_column_1.FontWeight = 'bold';
            comp.row_3_column_1.Layout.Row = 3;
            comp.row_3_column_1.Layout.Column = 2;
            comp.row_3_column_1.Text = '';

            % Create row_4_column_1
            comp.row_4_column_1 = uilabel(comp.GridLayout);
            comp.row_4_column_1.BackgroundColor = [1 1 1];
            comp.row_4_column_1.HorizontalAlignment = 'center';
            comp.row_4_column_1.FontName = 'ZapfDingbats';
            comp.row_4_column_1.FontSize = 36;
            comp.row_4_column_1.FontWeight = 'bold';
            comp.row_4_column_1.Layout.Row = 4;
            comp.row_4_column_1.Layout.Column = 2;
            comp.row_4_column_1.Text = '';

            % Create row_5_column_1
            comp.row_5_column_1 = uilabel(comp.GridLayout);
            comp.row_5_column_1.BackgroundColor = [1 1 1];
            comp.row_5_column_1.HorizontalAlignment = 'center';
            comp.row_5_column_1.FontName = 'ZapfDingbats';
            comp.row_5_column_1.FontSize = 36;
            comp.row_5_column_1.FontWeight = 'bold';
            comp.row_5_column_1.Layout.Row = 5;
            comp.row_5_column_1.Layout.Column = 2;
            comp.row_5_column_1.Text = '';

            % Create Image2
            comp.Image2 = uiimage(comp.GridLayout);
            comp.Image2.BackgroundColor = [1 1 1];
            comp.Image2.Layout.Row = [1 2];
            comp.Image2.Layout.Column = 1;
            comp.Image2.ImageSource = fullfile(pathToMLAPP, 'cracked_egg.png');

            % Create row_1_column_4
            comp.row_1_column_4 = uilabel(comp.GridLayout);
            comp.row_1_column_4.BackgroundColor = [1 1 1];
            comp.row_1_column_4.HorizontalAlignment = 'center';
            comp.row_1_column_4.FontName = 'ZapfDingbats';
            comp.row_1_column_4.FontSize = 36;
            comp.row_1_column_4.FontWeight = 'bold';
            comp.row_1_column_4.Layout.Row = 1;
            comp.row_1_column_4.Layout.Column = 5;
            comp.row_1_column_4.Text = '';

            % Create row_2_column_4
            comp.row_2_column_4 = uilabel(comp.GridLayout);
            comp.row_2_column_4.BackgroundColor = [1 1 1];
            comp.row_2_column_4.HorizontalAlignment = 'center';
            comp.row_2_column_4.FontName = 'ZapfDingbats';
            comp.row_2_column_4.FontSize = 36;
            comp.row_2_column_4.FontWeight = 'bold';
            comp.row_2_column_4.Layout.Row = 2;
            comp.row_2_column_4.Layout.Column = 5;
            comp.row_2_column_4.Text = '';

            % Create row_3_column_4
            comp.row_3_column_4 = uilabel(comp.GridLayout);
            comp.row_3_column_4.BackgroundColor = [1 1 1];
            comp.row_3_column_4.HorizontalAlignment = 'center';
            comp.row_3_column_4.FontName = 'ZapfDingbats';
            comp.row_3_column_4.FontSize = 36;
            comp.row_3_column_4.FontWeight = 'bold';
            comp.row_3_column_4.Layout.Row = 3;
            comp.row_3_column_4.Layout.Column = 5;
            comp.row_3_column_4.Text = '';

            % Create row_4_column_4
            comp.row_4_column_4 = uilabel(comp.GridLayout);
            comp.row_4_column_4.BackgroundColor = [1 1 1];
            comp.row_4_column_4.HorizontalAlignment = 'center';
            comp.row_4_column_4.FontName = 'ZapfDingbats';
            comp.row_4_column_4.FontSize = 36;
            comp.row_4_column_4.FontWeight = 'bold';
            comp.row_4_column_4.Layout.Row = 4;
            comp.row_4_column_4.Layout.Column = 5;
            comp.row_4_column_4.Text = '';

            % Create row_5_column_4
            comp.row_5_column_4 = uilabel(comp.GridLayout);
            comp.row_5_column_4.BackgroundColor = [1 1 1];
            comp.row_5_column_4.HorizontalAlignment = 'center';
            comp.row_5_column_4.FontName = 'ZapfDingbats';
            comp.row_5_column_4.FontSize = 36;
            comp.row_5_column_4.FontWeight = 'bold';
            comp.row_5_column_4.Layout.Row = 5;
            comp.row_5_column_4.Layout.Column = 5;
            comp.row_5_column_4.Text = '';

            % Create YouloseLabel
            comp.YouloseLabel = uilabel(comp.GridLayout);
            comp.YouloseLabel.BackgroundColor = [1 0 0];
            comp.YouloseLabel.HorizontalAlignment = 'center';
            comp.YouloseLabel.FontName = 'ZapfDingbats';
            comp.YouloseLabel.FontSize = 48;
            comp.YouloseLabel.FontWeight = 'bold';
            comp.YouloseLabel.Visible = 'off';
            comp.YouloseLabel.Layout.Row = [1 5];
            comp.YouloseLabel.Layout.Column = [1 6];
            comp.YouloseLabel.Text = '   You lose.';

            % Create restartButton
            comp.restartButton = uibutton(comp.GridLayout, 'push');
            comp.restartButton.ButtonPushedFcn = matlab.apps.createCallbackFcn(comp, @restartButtonPushed, true);
            comp.restartButton.BackgroundColor = [0.7098 0.702 0.702];
            comp.restartButton.FontName = 'ZapfDingbats';
            comp.restartButton.FontSize = 18;
            comp.restartButton.Visible = 'off';
            comp.restartButton.Layout.Row = 4;
            comp.restartButton.Layout.Column = [2 4];
            comp.restartButton.Text = 'restart';

            % Create ImpressiveLabel
            comp.ImpressiveLabel = uilabel(comp.GridLayout);
            comp.ImpressiveLabel.BackgroundColor = [0 0 0];
            comp.ImpressiveLabel.HorizontalAlignment = 'center';
            comp.ImpressiveLabel.FontName = 'ZapfDingbats';
            comp.ImpressiveLabel.FontSize = 18;
            comp.ImpressiveLabel.FontWeight = 'bold';
            comp.ImpressiveLabel.FontColor = [1 1 1];
            comp.ImpressiveLabel.Visible = 'off';
            comp.ImpressiveLabel.Layout.Row = 1;
            comp.ImpressiveLabel.Layout.Column = [2 4];
            comp.ImpressiveLabel.Text = 'Impressive.';

            % Create displaycorrectword
            comp.displaycorrectword = uilabel(comp.GridLayout);
            comp.displaycorrectword.BackgroundColor = [0 0 0];
            comp.displaycorrectword.HorizontalAlignment = 'center';
            comp.displaycorrectword.FontName = 'ZapfDingbats';
            comp.displaycorrectword.FontSize = 18;
            comp.displaycorrectword.FontWeight = 'bold';
            comp.displaycorrectword.FontColor = [1 1 1];
            comp.displaycorrectword.Visible = 'off';
            comp.displaycorrectword.Layout.Row = 1;
            comp.displaycorrectword.Layout.Column = [2 3];
            comp.displaycorrectword.Text = '';

            % Create directions
            comp.directions = uitextarea(comp.GridLayout);
            comp.directions.HorizontalAlignment = 'center';
            comp.directions.FontName = 'ZapfDingbats';
            comp.directions.FontSize = 18;
            comp.directions.FontWeight = 'bold';
            comp.directions.Layout.Row = [1 5];
            comp.directions.Layout.Column = [1 6];
            comp.directions.Value = {'  How to Play.'; ''; '  Guess the Wordle in 5 tries.'; ''; '    If the letter is in the correct position and in the correct word, the background of the letter will turn GREEN.'; ''; '    If the letter is in the correct word but not in the correct position, the background of the letter will turn YELLOW.'; ''; '    If the letter is not in the correct word, the background of the letter will turn GREY.'};

            % Create StarttheGameButton
            comp.StarttheGameButton = uibutton(comp.GridLayout, 'push');
            comp.StarttheGameButton.ButtonPushedFcn = matlab.apps.createCallbackFcn(comp, @StarttheGameButtonPushed, true);
            comp.StarttheGameButton.BackgroundColor = [0.9804 0.949 0.6549];
            comp.StarttheGameButton.FontName = 'ZapfDingbats';
            comp.StarttheGameButton.FontSize = 18;
            comp.StarttheGameButton.Layout.Row = 4;
            comp.StarttheGameButton.Layout.Column = [4 5];
            comp.StarttheGameButton.Text = 'Start the Game!';

            % Create Image
            comp.Image = uiimage(comp.GridLayout);
            comp.Image.Layout.Row = [4 5];
            comp.Image.Layout.Column = [1 3];
            comp.Image.ImageSource = fullfile(pathToMLAPP, 'cracked_egg.png');

            % Create playagain
            comp.playagain = uilabel(comp.GridLayout);
            comp.playagain.BackgroundColor = [1 0.9882 0.8];
            comp.playagain.HorizontalAlignment = 'center';
            comp.playagain.FontName = 'ZapfDingbats';
            comp.playagain.FontSize = 36;
            comp.playagain.FontWeight = 'bold';
            comp.playagain.Visible = 'off';
            comp.playagain.Layout.Row = [1 5];
            comp.playagain.Layout.Column = [1 6];
            comp.playagain.Text = 'Play again and guess a new word!';

            % Create RestartButton
            comp.RestartButton = uibutton(comp.GridLayout, 'push');
            comp.RestartButton.ButtonPushedFcn = matlab.apps.createCallbackFcn(comp, @RestartButtonPushed, true);
            comp.RestartButton.FontName = 'ZapfDingbats';
            comp.RestartButton.FontSize = 18;
            comp.RestartButton.Visible = 'off';
            comp.RestartButton.Layout.Row = 2;
            comp.RestartButton.Layout.Column = [2 4];
            comp.RestartButton.Text = 'Restart';

            % Create image3
            comp.image3 = uiimage(comp.GridLayout);
            comp.image3.Visible = 'off';
            comp.image3.Layout.Row = [4 5];
            comp.image3.Layout.Column = [2 4];
            comp.image3.ImageSource = fullfile(pathToMLAPP, 'cracked_egg.png');
        end
    end
end