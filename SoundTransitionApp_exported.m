classdef SoundTransitionApp_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                 matlab.ui.Figure
        UIAxes                   matlab.ui.control.UIAxes
        UIAxes2                  matlab.ui.control.UIAxes
        StartSliderLabel         matlab.ui.control.Label
        StartSlider              matlab.ui.control.Slider
        StartSlider_2Label       matlab.ui.control.Label
        StartSlider_2            matlab.ui.control.Slider
        TestPlayButton           matlab.ui.control.Button
        TestPlayButton_2         matlab.ui.control.Button
        PlaybackDropDown_3Label  matlab.ui.control.Label
        PlaybackDropDown         matlab.ui.control.DropDown
        LoadMusicAButton         matlab.ui.control.Button
        LoadMusicBButton         matlab.ui.control.Button
        PlaybackDropDown_4Label  matlab.ui.control.Label
        PlaybackDropDown_2       matlab.ui.control.DropDown
        MergeButton              matlab.ui.control.Button
        PlayButton               matlab.ui.control.Button
        ExportButton             matlab.ui.control.Button
        DJMixerLabel             matlab.ui.control.Label
        StudentNameLabel         matlab.ui.control.Label
        StudentIDLabel           matlab.ui.control.Label
        ABDULLAHISHEHULabel      matlab.ui.control.Label
        Label                    matlab.ui.control.Label
        HelpButton               matlab.ui.control.StateButton
        EndSliderLabel           matlab.ui.control.Label
        EndSlider                matlab.ui.control.Slider
        EndSlider_2Label         matlab.ui.control.Label
        EndSlider_2              matlab.ui.control.Slider
        UIAxes3                  matlab.ui.control.UIAxes
    end

    
    properties (Access = private)
        load_music_a % Loaded Music A
        freq_a
        bool_music_a = false;
        play_music_a
        play_music_a_freq
        
        load_music_b
        freq_b
        bool_music_b = false;
        play_music_b
        play_music_b_freq
        
        play_music_mixed
    end
    
    properties (Access = public)
        player_a % Description
        player_b
        player_mixed
    end
    
    

    % Callbacks that handle component events
    methods (Access = private)

        % Button pushed function: LoadMusicAButton
        function LoadMusicAButtonPushed(app, event)
            [file, path] = uigetfile({'*.wav; *.mp3; *.m4a'});
            fullpath = fullfile(path, file);
            try
                [app.load_music_a, app.freq_a] = audioread(fullpath);
                app.load_music_a = app.load_music_a(:, 1);
                app.play_music_a = app.load_music_a;
            catch
                return                
            end
            
            app.bool_music_a = true;
            
            amp = app.load_music_a;
            period = 1/app.freq_a;
            time = 0:period:(length(amp)*period - period);
            
            plot(app.UIAxes, time, amp);
            app.UIAxes.XLim = [0, int16(length(amp)*period - period)];
            
            app.StartSlider.Enable = true;
            app.EndSlider.Enable = true;
            app.PlaybackDropDown.Enable = true;
            app.TestPlayButton.Enable = true;
            app.UIAxes.Visible = true;
            
            app.StartSlider.Limits = [0, round(max(time))];
            app.EndSlider.Limits = [0, round(max(time))];
            
            app.StartSlider.Value = 0;
            app.EndSlider.Value = round(max(time));
            
            if app.bool_music_b == true
                app.MergeButton.Enable = true;
            end
        end

        % Button pushed function: TestPlayButton
        function TestPlayButtonPushed(app, event)
            drpdwnValue = str2double(app.PlaybackDropDown.Value);
            app.play_music_a_freq = round(drpdwnValue * app.freq_a);
            app.player_a = audioplayer(app.play_music_a, app.play_music_a_freq);
            play(app.player_a)
        end

        % Button pushed function: LoadMusicBButton
        function LoadMusicBButtonPushed(app, event)
            [file, path] = uigetfile({'*.wav; *.mp3; *.m4a'});
            fullpath = fullfile(path, file);
            try
                [app.load_music_b, app.freq_b] = audioread(fullpath);
                app.load_music_b = app.load_music_b(:, 1);
                app.play_music_b = app.load_music_b;
            catch
                return                
            end
            
            app.bool_music_b = true;
            
            amp = app.load_music_b;
            period = 1/app.freq_b;
            time = 0:period:(length(amp)*period - period);
            
            plot(app.UIAxes2, time, amp);
            app.UIAxes2.XLim = [0, int16(length(amp)*period - period)];
            
            app.StartSlider_2.Enable = true;
            app.EndSlider_2.Enable = true;
            app.PlaybackDropDown_2.Enable = true;
            app.TestPlayButton_2.Enable = true;
            app.UIAxes2.Visible = true;
            
            app.StartSlider_2.Limits = [0, round(max(time))];
            app.EndSlider_2.Limits = [0, round(max(time))];
            
            app.StartSlider_2.Value = 0;
            app.EndSlider_2.Value = round(max(time));
            
            if app.bool_music_a == true
                app.MergeButton.Enable = true;
            end
        end

        % Button pushed function: TestPlayButton_2
        function TestPlayButton_2Pushed(app, event)
            drpdwnValue = str2double(app.PlaybackDropDown_2.Value);
            app.play_music_b_freq = round(drpdwnValue * app.freq_b);
            app.player_b = audioplayer(app.play_music_b, app.play_music_b_freq);
            play(app.player_b)
        end

        % Value changed function: StartSlider
        function StartSliderValueChanged(app, event)
            start_value = app.StartSlider.Value;
            end_value = app.EndSlider.Value;
            
            
            if start_value >= end_value
                start_value = app.StartSlider.Limits(1);
                app.StartSlider.Value = start_value;
            end
            
            app.play_music_a = app.load_music_a(start_value:end_value);
        end

        % Value changed function: EndSlider
        function EndSliderValueChanged(app, event)
            start_value = app.StartSlider.Value;
            end_value = app.EndSlider.Value;
            
            
            if end_value <= start_value
                end_value = app.EndSlider.Limits(2);
                app.EndSlider.Value = end_value;
            end
            
            app.play_music_a = app.load_music_a(start_value:end_value);
        end

        % Value changed function: StartSlider_2
        function StartSlider_2ValueChanged(app, event)
            start_value = app.StartSlider_2.Value;
            end_value = app.EndSlider_2.Value;
            
            
            if start_value >= end_value
                start_value = app.StartSlider_2.Limits(1);
                app.StartSlider_2.Value = start_value;
            end
            
            app.play_music_b = app.load_music_b(start_value:end_value);
            
        end

        % Value changed function: EndSlider_2
        function EndSlider_2ValueChanged(app, event)
            start_value = app.StartSlider_2.Value;
            end_value = app.EndSlider_2.Value;
            
            
            if end_value <= start_value
                end_value = app.EndSlider_2.Limits(2);
                app.EndSlider_2.Value = end_value;
            end
            
            app.play_music_b = app.load_music_b(start_value:end_value);
            
        end

        % Button pushed function: MergeButton
        function MergeButtonPushed(app, event)
            app.PlayButton.Enable = true;
            app.ExportButton.Enable = true;
            app.UIAxes3.Visible = true;
            
            signal_a = app.play_music_a;
            signal_b = app.play_music_b;
            
            %freq_a = app.play_music_a_freq;
            %freq_b = app.play_music_b_freq;
            
            
            if length(signal_a) <= length(signal_b)
               sig_length = length(signal_a);
            else
                sig_length = length(signal_b);
            end
            
            n = round(sig_length / 5);
            
            tune_down = linspace(1,0,n)';
            
            signal_a(end-n+1:end) = signal_a(end-n+1:end) .* tune_down;
            signal_b(1:n) = signal_b(1:n) .* (1 - tune_down);
            signal_mixed = zeros(size(signal_a,1) + size(signal_b, 1) - n, 1);
            signal_mixed(1:size(signal_a, 1)) = signal_a;
            signal_mixed(end-size(signal_a, 1)+n+1:end) = signal_mixed(end-size(signal_a,1)+n+1:end) + signal_b;

            app.play_music_mixed = signal_mixed;
        end

        % Button pushed function: PlayButton
        function PlayButtonPushed(app, event)
            app.player_mixed = audioplayer(app.play_music_mixed);
            play(app.play_music_mixed)
        end

        % Button pushed function: ExportButton
        function ExportButtonPushed(app, event)
            [filename, path] = uiputfile({'*.wav; *.mp3; *.m4a'});
            
            if ~isequal(file, 0)
                audiowrite(fullfile(path, filename), app.play_music_mixed);
            end
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.Position = [100 100 868 761];
            app.UIFigure.Name = 'MATLAB App';

            % Create UIAxes
            app.UIAxes = uiaxes(app.UIFigure);
            title(app.UIAxes, 'Music 1')
            xlabel(app.UIAxes, 'Time')
            ylabel(app.UIAxes, 'Amplitude')
            app.UIAxes.FontName = 'Arial';
            app.UIAxes.Visible = 'off';
            app.UIAxes.BackgroundColor = [0.902 0.902 0.902];
            app.UIAxes.Position = [59 445 300 185];

            % Create UIAxes2
            app.UIAxes2 = uiaxes(app.UIFigure);
            title(app.UIAxes2, 'Music 2')
            xlabel(app.UIAxes2, 'Time')
            ylabel(app.UIAxes2, 'Amplitude')
            app.UIAxes2.Visible = 'off';
            app.UIAxes2.BackgroundColor = [0.902 0.902 0.902];
            app.UIAxes2.Position = [497 445 300 185];

            % Create StartSliderLabel
            app.StartSliderLabel = uilabel(app.UIFigure);
            app.StartSliderLabel.HorizontalAlignment = 'right';
            app.StartSliderLabel.Enable = 'off';
            app.StartSliderLabel.Position = [50 408 31 22];
            app.StartSliderLabel.Text = 'Start';

            % Create StartSlider
            app.StartSlider = uislider(app.UIFigure);
            app.StartSlider.ValueChangedFcn = createCallbackFcn(app, @StartSliderValueChanged, true);
            app.StartSlider.Enable = 'off';
            app.StartSlider.Position = [102 417 246 3];

            % Create StartSlider_2Label
            app.StartSlider_2Label = uilabel(app.UIFigure);
            app.StartSlider_2Label.HorizontalAlignment = 'right';
            app.StartSlider_2Label.Enable = 'off';
            app.StartSlider_2Label.Position = [485 408 31 22];
            app.StartSlider_2Label.Text = 'Start';

            % Create StartSlider_2
            app.StartSlider_2 = uislider(app.UIFigure);
            app.StartSlider_2.ValueChangedFcn = createCallbackFcn(app, @StartSlider_2ValueChanged, true);
            app.StartSlider_2.Enable = 'off';
            app.StartSlider_2.Position = [537 417 262 3];

            % Create TestPlayButton
            app.TestPlayButton = uibutton(app.UIFigure, 'push');
            app.TestPlayButton.ButtonPushedFcn = createCallbackFcn(app, @TestPlayButtonPushed, true);
            app.TestPlayButton.Enable = 'off';
            app.TestPlayButton.Position = [159 299 100 22];
            app.TestPlayButton.Text = 'Test Play';

            % Create TestPlayButton_2
            app.TestPlayButton_2 = uibutton(app.UIFigure, 'push');
            app.TestPlayButton_2.ButtonPushedFcn = createCallbackFcn(app, @TestPlayButton_2Pushed, true);
            app.TestPlayButton_2.Enable = 'off';
            app.TestPlayButton_2.Position = [597 299 100 22];
            app.TestPlayButton_2.Text = 'Test Play';

            % Create PlaybackDropDown_3Label
            app.PlaybackDropDown_3Label = uilabel(app.UIFigure);
            app.PlaybackDropDown_3Label.HorizontalAlignment = 'right';
            app.PlaybackDropDown_3Label.Enable = 'off';
            app.PlaybackDropDown_3Label.Position = [180 644 54 22];
            app.PlaybackDropDown_3Label.Text = 'Playback';

            % Create PlaybackDropDown
            app.PlaybackDropDown = uidropdown(app.UIFigure);
            app.PlaybackDropDown.Items = {'Very Slow', 'Slow', 'Normal', 'Fast', 'Very Fast'};
            app.PlaybackDropDown.ItemsData = {'0.25', '0.5', '1', '1.5', '2'};
            app.PlaybackDropDown.Enable = 'off';
            app.PlaybackDropDown.Position = [236 644 100 22];
            app.PlaybackDropDown.Value = '1';

            % Create LoadMusicAButton
            app.LoadMusicAButton = uibutton(app.UIFigure, 'push');
            app.LoadMusicAButton.ButtonPushedFcn = createCallbackFcn(app, @LoadMusicAButtonPushed, true);
            app.LoadMusicAButton.Position = [37 644 100 22];
            app.LoadMusicAButton.Text = 'Load Music A';

            % Create LoadMusicBButton
            app.LoadMusicBButton = uibutton(app.UIFigure, 'push');
            app.LoadMusicBButton.ButtonPushedFcn = createCallbackFcn(app, @LoadMusicBButtonPushed, true);
            app.LoadMusicBButton.Position = [497 644 100 22];
            app.LoadMusicBButton.Text = 'Load Music B';

            % Create PlaybackDropDown_4Label
            app.PlaybackDropDown_4Label = uilabel(app.UIFigure);
            app.PlaybackDropDown_4Label.HorizontalAlignment = 'right';
            app.PlaybackDropDown_4Label.Enable = 'off';
            app.PlaybackDropDown_4Label.Position = [654 644 54 22];
            app.PlaybackDropDown_4Label.Text = 'Playback';

            % Create PlaybackDropDown_2
            app.PlaybackDropDown_2 = uidropdown(app.UIFigure);
            app.PlaybackDropDown_2.Items = {'Very Slow', 'Slow', 'Normal', 'Fast', 'Very Fast'};
            app.PlaybackDropDown_2.ItemsData = {'0.25', '0.5', '1', '1.5', '2.0'};
            app.PlaybackDropDown_2.Enable = 'off';
            app.PlaybackDropDown_2.Position = [710 644 100 22];
            app.PlaybackDropDown_2.Value = '1';

            % Create MergeButton
            app.MergeButton = uibutton(app.UIFigure, 'push');
            app.MergeButton.ButtonPushedFcn = createCallbackFcn(app, @MergeButtonPushed, true);
            app.MergeButton.Enable = 'off';
            app.MergeButton.Position = [197 43 146 50];
            app.MergeButton.Text = {'Merge'; ''};

            % Create PlayButton
            app.PlayButton = uibutton(app.UIFigure, 'push');
            app.PlayButton.ButtonPushedFcn = createCallbackFcn(app, @PlayButtonPushed, true);
            app.PlayButton.Enable = 'off';
            app.PlayButton.Position = [359 43 146 50];
            app.PlayButton.Text = 'Play';

            % Create ExportButton
            app.ExportButton = uibutton(app.UIFigure, 'push');
            app.ExportButton.ButtonPushedFcn = createCallbackFcn(app, @ExportButtonPushed, true);
            app.ExportButton.Enable = 'off';
            app.ExportButton.Position = [526 43 146 50];
            app.ExportButton.Text = 'Export';

            % Create DJMixerLabel
            app.DJMixerLabel = uilabel(app.UIFigure);
            app.DJMixerLabel.HorizontalAlignment = 'center';
            app.DJMixerLabel.FontName = 'Lucida Handwriting';
            app.DJMixerLabel.FontSize = 40;
            app.DJMixerLabel.Position = [308 678 234 57];
            app.DJMixerLabel.Text = 'DJ Mixer';

            % Create StudentNameLabel
            app.StudentNameLabel = uilabel(app.UIFigure);
            app.StudentNameLabel.FontName = 'Arial';
            app.StudentNameLabel.FontSize = 14;
            app.StudentNameLabel.Position = [443 12 99 22];
            app.StudentNameLabel.Text = 'Student Name:';

            % Create StudentIDLabel
            app.StudentIDLabel = uilabel(app.UIFigure);
            app.StudentIDLabel.FontName = 'Arial';
            app.StudentIDLabel.FontSize = 14;
            app.StudentIDLabel.Position = [704 12 76 22];
            app.StudentIDLabel.Text = 'Student ID:';

            % Create ABDULLAHISHEHULabel
            app.ABDULLAHISHEHULabel = uilabel(app.UIFigure);
            app.ABDULLAHISHEHULabel.FontName = 'Arial';
            app.ABDULLAHISHEHULabel.FontSize = 14;
            app.ABDULLAHISHEHULabel.FontWeight = 'bold';
            app.ABDULLAHISHEHULabel.Position = [541 12 140 22];
            app.ABDULLAHISHEHULabel.Text = 'ABDULLAHI SHEHU';

            % Create Label
            app.Label = uilabel(app.UIFigure);
            app.Label.FontName = 'Arial';
            app.Label.FontSize = 14;
            app.Label.FontWeight = 'bold';
            app.Label.Position = [779 12 68 22];
            app.Label.Text = '18431658';

            % Create HelpButton
            app.HelpButton = uibutton(app.UIFigure, 'state');
            app.HelpButton.Text = 'Help';
            app.HelpButton.Position = [785 734 79 20];

            % Create EndSliderLabel
            app.EndSliderLabel = uilabel(app.UIFigure);
            app.EndSliderLabel.HorizontalAlignment = 'right';
            app.EndSliderLabel.Enable = 'off';
            app.EndSliderLabel.Position = [54 355 27 22];
            app.EndSliderLabel.Text = 'End';

            % Create EndSlider
            app.EndSlider = uislider(app.UIFigure);
            app.EndSlider.ValueChangedFcn = createCallbackFcn(app, @EndSliderValueChanged, true);
            app.EndSlider.Enable = 'off';
            app.EndSlider.Position = [102 364 246 3];

            % Create EndSlider_2Label
            app.EndSlider_2Label = uilabel(app.UIFigure);
            app.EndSlider_2Label.HorizontalAlignment = 'right';
            app.EndSlider_2Label.Enable = 'off';
            app.EndSlider_2Label.Position = [489 355 27 22];
            app.EndSlider_2Label.Text = 'End';

            % Create EndSlider_2
            app.EndSlider_2 = uislider(app.UIFigure);
            app.EndSlider_2.ValueChangedFcn = createCallbackFcn(app, @EndSlider_2ValueChanged, true);
            app.EndSlider_2.Enable = 'off';
            app.EndSlider_2.Position = [537 364 262 3];

            % Create UIAxes3
            app.UIAxes3 = uiaxes(app.UIFigure);
            title(app.UIAxes3, 'Merged Music')
            xlabel(app.UIAxes3, 'Time')
            ylabel(app.UIAxes3, 'Amplitude')
            app.UIAxes3.Visible = 'off';
            app.UIAxes3.BackgroundColor = [0.902 0.902 0.902];
            app.UIAxes3.Position = [119 101 632 185];

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = SoundTransitionApp_exported

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end